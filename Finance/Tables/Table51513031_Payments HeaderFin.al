table 51513031 "Payments HeaderFin"
{
    DataClassification = CustomerContent;
    Caption = 'Payments HeaderFin';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            //Editable = false;

            trigger onValidate()

            begin

                IF "Payment Type" = "Payment Type"::"Payment Voucher" THEN BEGIN
                    IF "No." <> xRec."No." THEN begin
                        NoSeriesBuffer.Reset();
                        NoSeriesBuffer.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                        NoSeriesBuffer.SetRange("Document Type", NoSeriesBuffer."Document Type"::PV);
                        if NoSeriesBuffer.Find('-') then begin
                            NoSeriesMgt.TestManual(NoSeriesBuffer."No. Series");
                        end;
                    end;
                END;

                IF "Payment Type" = "Payment Type"::"Petty Cash" THEN BEGIN
                    IF "No." <> xRec."No." THEN begin
                        NoSeriesBuffer.Reset();
                        NoSeriesBuffer.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                        NoSeriesBuffer.SetRange("Document Type", NoSeriesBuffer."Document Type"::"Petty Cash");
                        if NoSeriesBuffer.Find('-') then begin
                            NoSeriesMgt.TestManual(NoSeriesBuffer."No. Series");
                        end;
                    end;
                END;

                IF "Payment Type" = "Payment Type"::"Imprest Requisitioning" THEN BEGIN
                    IF "No." <> xRec."No." THEN
                        NoSeriesMgt.TestManual(GLSetup."Imprest Nos");
                END;

                IF "Surrender Type" = "Surrender Type"::Surrender THEN BEGIN
                    IF "No." <> xRec."No." THEN
                        NoSeriesMgt.TestManual(GLSetup."Imprest Surrender No");
                    "Imprest Surrender Date" := Today
                END;


            end;

        }
        field(2; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';

            trigger OnValidate()

            begin

                CASE "Payment Type" OF
                    "Payment Type"::"Imprest Requisitioning":
                        BEGIN
                            //Get the Imprest Deadline Date
                            IF NOT CashMgt.GET THEN
                                ERROR(Text000);
                            CashMgt.TESTFIELD("Imprest Due Date");
                            IF Date <> 0D THEN
                                "Imprest Deadline" := CALCDATE(CashMgt."Imprest Due Date", Date);
                        END;
                END;
            end;
        }
        field(3; Type; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(4; "Pay Mode"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pay Mode';
            TableRelation = "Pay Modes";
        }
        field(5; "Cheque No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque No';

            trigger Onvalidate()

            begin

                IF "Cheque No" <> '' THEN BEGIN
                    PV.RESET;
                    PV.SETRANGE(PV."Cheque No", "Cheque No");
                    IF PV.FIND('-') THEN BEGIN
                        IF PV."No." <> "No." THEN
                            ERROR('Cheque No. already exists');
                    END;
                END;
            end;
        }
        field(6; "Cheque Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Cheque Date';
        }
        field(7; "Bank Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Code';
        }
        field(8; Payee; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Payee';
        }
        field(9; "On behalf of"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'On behalf of';
        }
        field(10; Cashier; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Cashier';
            Editable = false;
        }
        field(11; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Posted';
            Editable = false;
        }
        field(12; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Posted By';
            Editable = false;
        }
        field(13; "Posted Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Posted Date';
            Editable = false;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");

                //validate("Dimension Set ID");
            end;

        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");

                //validate("Dimension Set ID");
            end;
        }
        field(16; "Time Posted"; Time)
        {
            DataClassification = CustomerContent;
            caption = 'Time Posted';
        }
        field(17; "Total Amount"; Decimal)
        {
            // DataClassification = CustomerContent;
            caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("PV Lines1"."Net Amount" WHERE(No = FIELD("No.")));
            Editable = false;
        }
        field(18; "Paying Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Paying Bank Account';
            TableRelation = "Bank Account";

            trigger OnValidate()
            var

            begin
                IF "Paying Bank Account" <> '' THEN BEGIN
                    Bank.GET("Paying Bank Account");
                    Currency := Bank."Currency Code";
                    Validate(Currency);
                END ELSE BEGIN
                    Currency := '';
                    Validate(Currency);
                END;
            end;
        }
        field(19; Status; Option)
        {
            OptionMembers = Open,"Pending Approval","Pending Prepayment",Released,Rejected,Closed;
            DataClassification = ToBeClassified;
            Caption = 'Status';
            Editable = false;
        }
        field(20; "Payment Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Payment Type';
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",None,MemberApplication,Contributions,LoanApplication,TopUpForm,EmployerForm,FosaAccountApplication,"Standing Orders","Cheque Requisition","Teller Request","Imprest Requisitioning",Imprest,"Imprest Surrender","Purchase Requisition","Store Requisition","Payment Voucher","Staff Claim","Petty Cash";
        }
        field(21; Currency; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency';
            TableRelation = Currency;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Currency <> '' THEN BEGIN
                    //GetCurrency;
                    IF (Currency <> xRec.Currency) OR
                       (CurrFieldNo = FIELDNO(Currency)) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate(Today, Currency);
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;

        }
        field(22; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(23; "Account Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Account Type';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(24; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Account No.';

            trigger OnLookUp()

            begin

                CASE "Account Type" OF
                    "Account Type"::"G/L Account":
                        BEGIN
                            IF PAGE.RUNMODAL(18, GLAccount) = ACTION::LookupOK THEN BEGIN
                                "Account No." := GLAccount."No.";
                                "Account Name" := GLAccount.Name;
                            END;
                        END;
                    "Account Type"::Customer:
                        BEGIN
                            IF PAGE.RUNMODAL(22, Customer) = ACTION::LookupOK THEN BEGIN
                                "Account No." := Customer."No.";
                                "Account Name" := Customer.Name;
                                Payee := Customer.Name;
                            END;
                        END;
                    "Account Type"::Vendor:
                        BEGIN
                            IF PAGE.RUNMODAL(27, Vendor) = ACTION::LookupOK THEN BEGIN
                                "Account No." := Vendor."No.";
                                "Account Name" := Vendor.Name;
                                Payee := Vendor.Name;
                            END;
                        END;


                    "Account Type"::"Fixed Asset":
                        BEGIN
                            IF PAGE.RUNMODAL(5601, FixedAsset) = ACTION::LookupOK THEN BEGIN
                                "Account No." := FixedAsset."No.";
                                "Account Name" := FixedAsset.Description;
                            END;
                        END;
                END;
            end;
        }
        field(25; "Account Name"; Text[50])
        {
            DataClassification = customercontent;
            Caption = 'Account Name';
        }
        field(26; "Imprest Amount"; Decimal)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = Sum("Imprest Lines".Amount WHERE(No = FIELD("No.")));
            caption = 'Imprest Amount';
            Editable = false;
        }
        field(27; Surrendered; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Surrendered';
        }
        field(28; "Applies- To Doc No."; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Applies- To Doc No.';
            trigger OnLookUp()

            begin

                CASE "Account Type" OF
                    "Account Type"::Customer:

                        BEGIN
                            CustLedger.RESET;
                            CustLedger.SETCURRENTKEY(CustLedger."Customer No.", Open, "Document No.");
                            CustLedger.SETRANGE(CustLedger."Customer No.", "Account No.");
                            CustLedger.SETRANGE(Open, TRUE);
                            CustLedger.CALCFIELDS(CustLedger.Amount);
                            IF PAGE.RUNMODAL(25, CustLedger) = ACTION::LookupOK THEN BEGIN

                                "Applies- To Doc No." := CustLedger."Document No.";

                            END;

                        END;
                END;
            end;
        }
        field(29; "Petty Cash Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Petty Cash Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Petty Cash Lines".Amount WHERE(No = FIELD("No.")));
        }
        field(30; "Original Document"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Original Document';
            OptionMembers = ,Imprest,"Staff Claim";
        }
        field(31; "PV Creation DateTime"; datetime)
        {
            DataClassification = CustomerContent;
            caption = 'PV Creation DateTime';
        }
        field(32; "PV Creator ID"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'PV Creator ID';
        }
        field(33; "Remaining Amount"; Decimal)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Sum("Imprest Lines"."Remaining Amount" WHERE(No = FIELD("No.")));
            caption = 'Remaining Amount';
        }
        field(34; "Receipt Created"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Receipt Created';
        }
        field(35; "Imprest Deadline"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Imprest Deadline';
            Editable = false;
        }
        field(36; "Imprest Surrender Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Imprest Surrender Date';
        }
        field(37; "Date Filter"; Date)
        {
            FieldClass = FlowField;
            Caption = 'Date Filter';
        }
        field(38; "Surrender Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Surrender Type';
            OptionMembers = ,Surrender;
        }
        field(39; "Surrender Imprest No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Surrender Imprest No';

            trigger OnValidate()

            begin

                PV.Reset();
                PV.SetRange("Employee No", Rec."Employee No");
                pv.SetRange("No.", '<>%1', Rec."No.");
                PV.SetRange("Surrender Imprest No", Rec."Surrender Imprest No");
                if PV.Find('-') then begin
                    Error('Employee Number %1 has already attached this Imprest to Retirement document number %2.', "Employee No", PV."No.");
                end;


                PV.Reset;
                PV.SetRange("Payment Type", "Payment Type"::"Imprest Surrender");
                PV.SetFilter(Status, '<>%1&<>%2', Status::Open, Status::Rejected);
                PV.SetRange("Surrender Imprest No", "Surrender Imprest No");
                if PV.FindFirst then
                    Error('Imprest Surrender for %1 is %2', "Surrender Imprest No", PV.Status);

                PV.RESET;
                PV.SETRANGE("Payment Type", "Payment Type"::"Imprest Requisitioning");
                pv.SetRange("No.", "Surrender Imprest No");
                PV.SETRANGE(Posted, TRUE);
                PV.SETRANGE(Surrendered, FALSE);
                PV.SETRANGE(Cashier, USERID);
                if PV.Find('-') then begin
                    Date := PV.Date;
                    Type := PV.Type;
                    "Pay Mode" := PV."Pay Mode";
                    Payee := PV.Payee;
                    "On behalf of" := PV."On behalf of";
                    Cashier := PV.Cashier;
                    "Global Dimension 1 Code" := PV."Global Dimension 1 Code";
                    Validate("Global Dimension 1 Code");
                    "Global Dimension 2 Code" := PV."Global Dimension 2 Code";
                    Validate("Global Dimension 2 Code");
                    "Dimension Set ID" := PV."Dimension Set ID";
                    "Time Posted" := PV."Time Posted";
                    "Paying Bank Account" := PV."Paying Bank Account";
                    Currency := PV.Currency;
                    "Currency Factor" := PV."Currency Factor";
                    Status := Status::Open;
                    //"Payment Type" := PV."Payment Type";
                    "Account Type" := PV."Account Type";
                    "Account No." := PV."Account No.";
                    "Account Name" := PV."Account Name";
                    Surrendered := PV.Surrendered;
                    "Imprest Deadline" := PV."Imprest Deadline";
                    "Memo Reference" := PV."Memo Reference";
                    "Employee No" := PV."Employee No";
                    "Imprest Rate" := PV."Imprest Rate";
                    "No. of Days" := PV."No. of Days";
                    "DSA Option" := PV."DSA Option";

                    MODIFY(TRUE);

                    PVLines.Reset();
                    PVLines.SetRange(No, "No.");
                    if PVLines.FindSet() then
                        PVLines.DeleteAll();

                    PVLines.RESET;
                    PVLines.SETRANGE(PVLines.No, "Surrender Imprest No");
                    IF PVLines.FIND('-') THEN BEGIN
                        REPEAT

                            PVLinesRec.INIT;
                            PVLinesRec.No := "No.";
                            PVLinesRec."Line No" := PVLines."Line No";
                            PVLinesRec."Account Type" := PVLines."Account Type";
                            PVLinesRec."Account No." := PVLines."Account No.";
                            PVLinesRec."Account Name" := PVLines."Account Name";
                            PVLinesRec.Description := PVLines.Description;
                            PVLinesRec."Currency Code" := PVLines."Currency Code";
                            PVLinesRec."Currency Factor" := PVLines."Currency Factor";
                            PVLinesRec.Amount := PVLines.Amount;
                            PVLinesRec."Applies- to Doc. No." := PVLines."Applies- to Doc. No.";
                            PVLinesRec."Global Dimension 1 Code" := PVLines."Global Dimension 1 Code";
                            PVLinesRec.Validate("Global Dimension 1 Code");
                            PVLinesRec."Global Dimension 2 Code" := PVLines."Global Dimension 2 Code";
                            PVLinesRec.Validate("Global Dimension 1 Code");
                            PVLinesRec."Dimension Set ID" := PVLines."Dimension Set ID";
                            PVLinesRec.Validate("Dimension Set ID");
                            PVLinesRec."Actual Spent" := PVLines."Actual Spent";
                            PVLinesRec."Remaining Amount" := PVLines."Remaining Amount";
                            PVLinesRec."Transaction Type" := PVLines."Transaction Type";
                            PVLinesRec."Expense Type" := PVLines."Expense Type";
                            IF NOT PVLinesRec.GET(PVLinesRec.No, PVLines."Line No") THEN
                                PVLinesRec.INSERT
                            ELSE
                                PVLinesRec.MODIFY;

                        UNTIL PVLines.NEXT = 0;
                    END;
                end;
            end;

            trigger OnLookup()

            begin
                PV.RESET;
                PV.SETRANGE("Payment Type", "Payment Type"::"Imprest Requisitioning");
                PV.SetRange(Status, Status::Released);
                PV.SETRANGE(Posted, TRUE);
                PV.SETRANGE(Surrendered, FALSE);
                PV.SETRANGE(Cashier, USERID);
                if PAGE.RUNMODAL(51513038, PV) = ACTION::LookupOK then begin
                    "Surrender Imprest No" := PV."No.";
                    Modify(true);
                    Validate("Surrender Imprest No");
                end;
            end;




        }
        field(40; "PV Created"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'PV Created';
        }
        field(41; "Imprest Payment"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Imprest Payment';
        }
        field(42; "Currency Factor"; Decimal)
        {
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF (Currency = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION(Currency)));
                PVLines.Reset();
                PVLines.SetRange(No, "No.");
                if PVLines.FindSet() then
                    repeat
                        PVLines."Currency Code" := Currency;
                        PVLines.Validate("Currency Code");
                        PVLines."Currency Factor" := "Currency Factor";
                        PVLines.Validate("Currency Factor");
                        PVLines.Modify();
                    until PVLines.Next() = 0;

                PettyCashLines.Reset();
                PettyCashLines.SetRange(No, "No.");
                if PettyCashLines.FindSet() then
                    repeat
                        PettyCashLines.Validate(Amount);
                        PettyCashLines.Modify();
                    until PettyCashLines.Next() = 0;
            end;

        }

        field(50; "Bank Call-Up "; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Bank Call-Up';

            trigger Onvalidate()

            begin
                if not "Bank Call-Up " then begin
                    "Claim No." := '';
                    "Claiming Bank Name" := '';
                    "Claiming Bank No." := '';
                    "Referrence No." := '';
                end;
            end;
        }
        field(51; "Claim No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Claim No.';
            TableRelation = "Claim"."No." where("Approval Status" = filter(Released), Status = filter(Pending));

            trigger Onvalidate()
            var
                ClaimRec: Record Claim;
            begin
                IF ClaimRec.Get("Claim No.") then begin
                    "Claiming Bank Name" := ClaimRec."Customer Name";
                    "Claiming Bank No." := ClaimRec."Customer No.";
                    "Referrence No." := ClaimRec."Reference No.";
                end else begin
                    "Claiming Bank Name" := '';
                    "Claiming Bank No." := '';
                    "Referrence No." := '';
                end;
            end;
        }
        field(52; "Claiming Bank No."; Code[50])
        {
            DataClassification = ToBeClassified;
            caption = 'Claim Bank No.';
            TableRelation = Customer;
            Editable = false;

        }

        field(53; "Claiming Bank Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Claiming Bank Name';
            Editable = false;
        }
        field(54; "Referrence No."; Code[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Referrence No.';
            Editable = false;
        }

        field(55; "Total Approved Claim Amount"; Decimal)
        {
            Caption = 'Total Approved Claim Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Guarantee Claim Line"."Claim Amount" where("Claim No." = field("Claim No."), "Approval Status" = filter(Approved)));
            Editable = false;
        }
        field(56; "Approved Clients"; Integer)
        {
            Caption = 'Approved Clients';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Guarantee Claim Line" where("Claim No." = field("Claim No."), "Approval Status" = filter(Approved)));
        }
        field(57; "Memo Reference"; Code[20])
        {
            TableRelation = "Memo Request Lines"."Header No." where("Employee No" = field("Employee No"), Released = const(true), "Attached to Imprest" = const(false));

            trigger OnValidate()
            var
                ObjMemo: Record "Memo Request Header";
                ObjMemoLines: Record "Memo Request Lines";
                ObjEmployee: Record Employee;
                ImprestRates: Record "Imprest Rates";
            begin

                PV.Reset();
                PV.SetRange("Employee No", Rec."Employee No");
                PV.SetRange("Memo Reference", Rec."Memo Reference");
                if PV.Find('-') then begin
                    Error('Employee Number %1 has already attached this Travel Memo to an imprest document number %2.', "Employee No", PV."No.");
                end;

                if ObjMemo.Get("Memo Reference") then begin
                    ObjMemoLines.Reset();
                    ObjMemoLines.SetRange("Header No.", "Memo Reference");
                    ObjMemoLines.SetRange("Employee No", "Employee No");
                    if ObjMemoLines.Find('-') then begin
                        "No. of Days" := ObjMemoLines."Number of Days";

                    end;
                    "DSA Option" := ObjMemoLines."DSA Option";
                    "Global Dimension 1 Code" := ObjMemo."Global Dimension 1 Code";
                    Validate("Global Dimension 1 Code");
                    "Global Dimension 2 Code" := ObjMemo."Global Dimension 2 Code";
                    Validate("Global Dimension 2 Code");
                    Currency := ObjMemo."Currency Code";
                    "Currency Factor" := ObjMemo."Currency Factor";

                    if ObjMemo."Trip Type" = ObjMemo."Trip Type"::local then begin
                        if ObjEmployee.Get("Employee No") then begin
                            ObjEmployee.TestField("Imprest Code");
                            if ImprestRates.Get(ObjEmployee."Imprest Code") then
                                "Imprest Rate" := ImprestRates.Amount;
                        end;
                    end else
                        if ObjMemo."Trip Type" = ObjMemo."Trip Type"::Foreign then
                            "Imprest Rate" := ObjMemo."Rate Per Day";


                end;

            end;
        }
        field(58; "Employee No"; Code[20])
        {
            TableRelation = Employee."No." where(Status = filter(Active));
        }

        field(59; "No. of Days"; Decimal)
        {

        }
        field(60; "Imprest Rate"; Decimal)
        {

        }
        field(61; "Petty Cash Amount(LCY)"; Decimal)
        {
            Editable = false;
            Caption = 'Petty Cash Amount(LCY)';
            FieldClass = FlowField;
            CalcFormula = Sum("Petty Cash Lines"."Net Amount LCY" WHERE(No = FIELD("No.")));
        }
        field(62; "DSA Option"; Option)
        {
            OptionMembers = " ","Full DSA","60% DSA","50% DSA";
        }
        field(63; "Total Days Spent"; Decimal)
        {

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PVLines.Reset();
                PVLines.SetRange(No, Rec."No.");
                if PVLines.FindSet() then
                    repeat
                        if (PVLines."Transaction Type" = 'DSA NON CLIENT') or (PVLines."Transaction Type" = 'DSA TO CLIENT') or (PVLines."Transaction Type" = 'DSAE') then begin
                            case "DSA Option" of
                                "DSA Option"::"Full DSA":
                                    begin
                                        PVLines."Actual Spent" := ("Imprest Rate" * "No. of Days");
                                    end;
                                "DSA Option"::"50% DSA":
                                    begin
                                        PVLines."Actual Spent" := (("Imprest Rate" * (50 / 100)) * ("No. of Days"));
                                    end;
                                "DSA Option"::"60% DSA":
                                    begin
                                        PVLines."Actual Spent" := (("Imprest Rate" * (60 / 100)) * ("No. of Days" - 1.5)) + ("Imprest Rate" * 1.5);
                                    end;

                            end;
                            PVLines.Validate("Actual Spent");
                            PVLines.Modify();
                        end;
                    until PVLines.Next() = 0;


            end;
        }
        field(64; "Transactions Source"; Option)
        {
            OptionMembers = "Normal Payments","Employee Transactions";
        }
        field(65; "Created By"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(66; "Transaction Description"; Text[50])
        {

        }
        field(480; "Dimension Set ID"; Integer)
        {
            editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;

            trigger OnLookUp()
            var
                myInt: Integer;
            begin
                ShowDimensions;
                //CurrPage.SAVERECORD;
            end;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(PK2; "Payment Type", "No.")
        {

        }
        key(PK3; "Posted Date", "No.")
        {

        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Bank: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        Amt: Integer;
        CustLedger: Record "Cust. Ledger Entry";
        CustLedger1: Record "Cust. Ledger Entry";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        PV: Record "Payments HeaderFin";
        CashMgt: Record "Cash Management Setup";
        PVLines: Record "Imprest Lines";
        PVLinesRec: Record "Imprest Lines";
        CurrExchRate: Record "Currency Exchange Rate";
        PettyCashLines: Record "Petty Cash Lines";
        Text000: TextConst ENU = 'Cash management setup does''nt exist';
        Text002: TextConst ENU = 'cannot be specified without %1';
        NoSeriesBuffer: Record "No. Series Buffer";
        PVLines1: Record "PV Lines1";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin

        GLSetup.GET();
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Global Dimension 1 Code");

            case "Payment Type" of
                "Payment Type"::"Payment Voucher":
                    begin
                        NoSeriesBuffer.Reset();
                        NoSeriesBuffer.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                        NoSeriesBuffer.SetRange("Document Type", NoSeriesBuffer."Document Type"::PV);
                        if NoSeriesBuffer.Find('-') then begin
                            NoSeriesBuffer.TESTFIELD(NoSeriesBuffer."No. Series");
                            IF "No." = '' THEN
                                NoSeriesMgt.InitSeries(NoSeriesBuffer."No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                        end else
                            Error('Please check the number series buffer page and populate it accordingly.');
                    end;
                "Payment Type"::"Petty Cash":
                    begin
                        NoSeriesBuffer.Reset();
                        NoSeriesBuffer.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                        NoSeriesBuffer.SetRange("Document Type", NoSeriesBuffer."Document Type"::"Petty Cash");
                        if NoSeriesBuffer.Find('-') then begin
                            NoSeriesBuffer.TESTFIELD(NoSeriesBuffer."No. Series");
                            IF "No." = '' THEN
                                NoSeriesMgt.InitSeries(NoSeriesBuffer."No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                        end else
                            Error('Please check the number series buffer page and populate it accordingly.');
                        "Pay Mode" := 'CASH';

                        //*********************Insert Paying Pettycash Bank acc*************************//
                        UserSetup1.Reset();
                        UserSetup1.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                        if UserSetup1.FindSet() then
                            repeat
                                Bank.Reset();
                                Bank.SetRange("Bank Acc Type", Bank."Bank Acc Type"::"Petty Cash");
                                Bank.SetRange("Cashier ID", UserSetup1."User ID");
                                if Bank.FindFirst() then begin
                                    "Paying Bank Account" := Bank."No.";

                                end;
                                Bank.Reset();
                                Bank.SetRange("Bank Acc Type", Bank."Bank Acc Type"::"Petty Cash");
                                Bank.SetRange("Cashier ID", UserId);
                                if Bank.FindFirst() then begin
                                    "Paying Bank Account" := Bank."No.";
                                end;
                                Validate("Paying Bank Account");
                            until UserSetup1.Next() = 0;

                        if "Paying Bank Account" = '' then
                            Error('There is no petty cash till linked to dimension code %1', UserSetup."Global Dimension 1 Code");

                        //*********************Insert Paying Pettycash Bank acc*************************//
                    end;
                "Payment Type"::"Imprest Requisitioning":
                    begin
                        GLSetup.TESTFIELD(GLSetup."Imprest Nos");
                        IF "No." = '' THEN
                            NoSeriesMgt.InitSeries(GLSetup."Imprest Nos", xRec."No. Series", 0D, "No.", "No. Series");
                        //Assign Customer Account
                        IF UserSetup.GET(USERID) THEN BEGIN
                            UserSetup.TESTFIELD("Imprest Account");
                            UserSetup.TestField("Employee No.");
                            "Employee No" := UserSetup."Employee No.";

                            IF Customer.GET(UserSetup."Imprest Account") THEN BEGIN
                                "Account Type" := "Account Type"::Customer;
                                "Account No." := Customer."No.";
                                "Account Name" := Customer.Name;
                                Payee := Customer.Name;
                            END ELSE
                                ERROR('Create an Imprest A/C for Employee No. %1 under the Finance Setup\Please contact system Administrator',
                                        UserSetup."Imprest Account");
                        END;
                    end;

            end;

            if "Surrender Type" = "Surrender Type"::Surrender then begin
                GLSetup.TESTFIELD(GLSetup."Imprest Surrender No");
                if "No." = '' then
                    NoSeriesMgt.InitSeries(GLSetup."Imprest Surrender No", xRec."No. Series", 0D, "No.", "No. Series");
            end;

            Date := TODAY;
            "Created By" := UserId;
        end else
            Error('User not well set up. Please contact your system administrator');


    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        Error('delete not allowed');
    end;

    trigger OnRename()
    begin

    end;

    procedure ShowDimensions()
    var
        myInt: Integer;
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2', Type, "No."),
            "Global Dimension 1 Code", "Global Dimension 2 Code");
        IF OldDimSetID <> "Dimension Set ID" then begin
            Modify();
        end;


        /*"Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2', Type, "No."), "Global Dimension 1 Code", "Global Dimension 2 Code");
        */
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        myInt: Integer;
    begin
        //TESTFIELD("Check Printed",FALSE);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    var
        myInt: Integer;
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure FnCheckValidationsBeforeApprovals(var ObjPaymentsH: Record "Payments HeaderFin")
    var
        myInt: Integer;
    begin
        if ObjPaymentsH."Global Dimension 1 Code" = '' then
            Error('Ensure that your transaction has a branch code before posting');


    end;

    [IntegrationEvent(false, false)]
    procedure OnAttachDocuments(var PanmentsH: Record "Payments HeaderFin")
    var
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnViewAttachedDocuments(var PanmentsH: Record "Payments HeaderFin")
    var
    begin

    end;
}
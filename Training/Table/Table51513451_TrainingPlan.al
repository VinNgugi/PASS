table 51513451 "Training Plan"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Budget Code"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ObjBudget.Get("Budget Code") then begin
                    "Budget Name" := ObjBudget.Description;
                end else begin
                    "Budget Name" := '';
                end;
            end;
        }
        field(3; "Budget Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Document Date"; Date)
        {
            Editable = false;
        }
        field(5; "Created By"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(6; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = filter (1), Blocked = filter (false));
            CaptionClass = '1,1,1';
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = filter (1), Blocked = filter (false));
            CaptionClass = '1,1,2';
        }
        field(9; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;

        }
        field(10; "Training Description"; Text[100])
        {

        }
        field(11; "Training Objective"; Text[100])
        {

        }

        field(12; "Training Start Date"; Date)
        {

        }
        field(13; "Training Period"; DateFormula)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                Clear("Training End Date");

                "Training End Date" := CalcDate("Training Period", "Training Start Date")

            end;
        }
        field(14; "Training End Date"; Date)
        {
            Editable = false;
        }
        field(15; "Destination Type"; Option)
        {
            Editable = false;
            OptionMembers = " ",Local,International;
        }
        field(16; "Training Destination"; Code[20])
        {
            //TableRelation = "SRC Scales-International";
        }
        field(17; "Training Type"; Option)
        {
            OptionMembers = " ",Seminar;
        }
        field(18; Sponsor; Option)
        {
            OptionMembers = " ",PASS,"Donor Funded";
        }
        field(19; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(20; "Training Classification"; Code[20])
        {
            TableRelation = "Training Classification"."Code.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                If Classification.Get("Training Classification") then begin
                    if Classification.Type = Classification.Type::local then
                        "Destination Type" := "Destination Type"::Local
                    else
                        if Classification.Type = Classification.Type::International then
                            "Destination Type" := "Destination Type"::International;

                    "G/L Account" := Classification."Account No";
                end
                else begin
                    Clear("Destination Type");
                    Clear("G/L Account");
                end;
            end;
        }
        field(21; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       ("Document Date" <> xRec."Document Date") OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate("Document Date", "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");


            end;
        }
        field(22; "Currency Factor"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));

                Participants.Reset();
                Participants.SetRange("Training Header No.", "Request No.");
                if Participants.FindSet() then
                    repeat
                        Participants."Currency Code" := "Currency Code";
                        Participants."Currency Factor" := "Currency Factor";
                        Participants.Validate("Currency Factor");
                        Participants.Modify();
                    until Participants.Next() = 0;
            end;
        }
        field(23; "Total Perdiem"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Per Diem" where ("Training Header No." = field ("Request No.")));
        }
        field(24; "Total Perdiem(LCY)"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Per Diem(LCY)" where ("Training Header No." = field ("Request No.")));

        }
        field(25; "Total Accomodation"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines".Accomodation where ("Training Header No." = field ("Request No.")));
        }
        field(26; "Total Accomodation(LCY)"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Accomodation(LCY)" where ("Training Header No." = field ("Request No.")));
        }
        field(27; "Total Air Ticket Fee"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Air Ticket Fee" where ("Training Header No." = field ("Request No.")));
        }
        field(28; "Total Air-Ticket(LCY)"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Air Ticket Fee(LCY)" where ("Training Header No." = field ("Request No.")));
        }
        field(29; "Total Travel-Expence"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Travel Expences" where ("Training Header No." = field ("Request No.")));
        }
        field(30; "Total Travel-Expence(LCY)"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Travel Expences(LCY)" where ("Training Header No." = field ("Request No.")));
        }
        field(31; "Gross Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Net Amount" where ("Training Header No." = field ("Request No.")));
        }
        field(32; "Gross Amount(LCY)"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Training Participants Lines"."Net Amount(LCY)" where ("Training Header No." = field ("Request No.")));
        }
        field(33; "Training Provider"; Code[20])
        {
            TableRelation = Vendor."No." where (Blocked = filter (" "));

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if Vendor.Get("Training Provider") then
                    "Training Provider Name" := Vendor.Name;
            end;
        }
        field(34; "Training Provider Name"; Text[100])
        {
            Editable = false;

        }


    }

    keys
    {
        key(PK; "Request No.")
        {
            Clustered = true;
        }
    }

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjBudget: Record "G/L Budget Name";
        Classification: Record "Training Classification";
        CurrExchRate: Record "Currency Exchange Rate";
        Participants: Record "Training Participants Lines";
        Text002: TextConst ENU = 'cannot be specified without %1';

    trigger OnInsert()
    begin
        if "Request No." = '' then begin
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD(HumanResSetup."Training Request Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Training Request Nos", xRec."No. Series", 0D, "Request No.", "No. Series");

            "Document Date" := Today;
            "Created By" := UserId;


        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
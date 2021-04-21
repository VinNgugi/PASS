table 51513601 "Guarantee Claim Line"
{
    DataClassification = CustomerContent;
    Caption = 'Guarantee Claim Line';
    fields
    {
        field(1; "Claim No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Claim No.';
            TableRelation = Claim;

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
        }

        field(3; "Contract No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract No.';
            TableRelation = "Guarantee Contracts" where("Contract Status" = filter("CGC Issued"));

            trigger Onvalidate()

            begin
                if ContractRec.Get("Contract No.") then begin
                    "Client Name" := ContractRec.Name;
                    "CGC No." := ContractRec."CGC No.";
                    "Client No." := ContractRec."Customer No.";
                    "CGC Date" := ContractRec."CGC Date";
                    "CGC Start Date" := ContractRec."CGC Start Date";
                    "CGC Expiry Date" := ContractRec."CGC Expiry Date";
                    "CGF %" := ContractRec."CGF %";
                    "Guarantee Source" := ContractRec."Guarantee Source";
                    "Approved Loan Amount" := ContractRec."Approved Loan Amount";
                    "Loan No." := ContractRec."Loan No.";
                    "Loan Maturity Date" := ContractRec."Loan Maturity Date";
                    "Global Dimension 1 Code" := ContractRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := ContractRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code" := ContractRec."Global Dimension 3 Code";
                    "Global Dimension 4 Code" := ContractRec."Global Dimension 4 Code";
                    Product := ContractRec.Product;
                    "SalesPerson Code" := ContractRec."BDS/BDO";
                    CalcFields("Outstanding Principal Amt");
                    if "CGF %" <> 0 then
                        "Payable Amount" := Round("Outstanding Principal Amt" * ("CGF %" / 100), 0.001, '<');

                    //*************** Insert Bank Recovery Lines*******************//
                    BankRecoveryLines.Reset();
                    BankRecoveryLines.SetRange("Claim No.", Rec."Claim No.");
                    BankRecoveryLines.SetRange("Contract No.", Rec."Contract No.");
                    if not BankRecoveryLines.FindSet() then
                        BankRecoveryLines.FnInsertBankRecoveryLines("Claim No.", "Contract No.", "CGC No.");
                    //*************** Insert Bank Recovery Lines*******************//

                end else begin
                    "Client Name" := '';
                    "CGC No." := '';
                    "CGC Date" := 0D;
                    "CGC Start Date" := 0D;
                    "CGC Expiry Date" := 0D;
                    "CGF %" := 0;
                    "Guarantee Source" := '';
                    "Approved Loan Amount" := 0;
                    "Loan No." := '';
                    "Loan Maturity Date" := 0D;
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Global Dimension 3 Code" := '';
                    "Global Dimension 4 Code" := '';
                    Product := '';
                    "Payable Amount" := 0;
                    "SalesPerson Code" := '';

                    //*************** Clear Bank Recovery Lines*******************//
                    BankRecoveryLines.Reset();
                    BankRecoveryLines.SetRange("Claim No.", Rec."Claim No.");
                    BankRecoveryLines.SetRange("Contract No.", Rec."Contract No.");
                    if BankRecoveryLines.FindSet() then
                        BankRecoveryLines.DeleteAll();
                    //*************** Clear Bank Recovery Lines*******************//
                end;

            end;
        }
        field(4; "Client Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Client Name';
            Editable = false;

        }
        field(5; "CGC No."; Code[50])
        {

            DataClassification = CustomerContent;
            Caption = 'CGC No.';
            Editable = false;
        }
        field(6; "CGC Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'CGC Date';
            Editable = false;

        }
        field(7; "CGC Start Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'CGC Start Date';
            Editable = false;
        }
        field(8; "CGF %"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'CGF %';
            Editable = false;



        }

        field(9; "CGC Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'CGC Expiry Date';
            Editable = false;

        }

        field(10; "Guarantee Source"; Code[20])
        {
            Caption = 'Guarantee Source';
            DataClassification = CustomerContent;
            Editable = false;


        }

        field(12; "Loan No."; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Loan No.';
            Editable = false;
        }
        field(13; "Loan Maturity Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Loan Maturity Date';
            Editable = false;
        }
        field(16; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Editable = false;
        }


        field(17; "Global Dimension 2 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Editable = false;
        }
        field(18; "Global Dimension 3 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            Editable = false;

        }
        field(19; "Global Dimension 4 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            Editable = false;

        }
        field(25; Product; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Product';
            NotBlank = true;
            TableRelation = Products;
            Editable = false;
        }
        field(26; "CGC Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'CGC Amount';
            Editable = false;


        }
        field(27; "Approved Loan Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Approved Loan Amount';
            Editable = false;

        }
        field(29; "Claim Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Claim Amount';

        }

        field(30; "Days in Arrears"; Integer)
        {

            Caption = 'Days in Arrears';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max ("Loan Account Entries"."Days Past Due" where("Contract No." = field("Contract No.")));
        }
        field(31; "Last Aging Date"; Date)
        {

            Caption = 'Last Aging Date';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max ("Loan Account Entries"."Reporting Date" where("Contract No." = field("Contract No.")));
        }
        field(32; "Outstanding Principal Amt"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Outstanding Principal Amt';
            CalcFormula = max ("Loan Account Entries"."Outstanding Principal Amt" where("Contract No." = field("Contract No.")));
        }
        field(35; "Payable Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Payable Amount';
            //Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;

        }
        field(39; "Approval Status"; Option)
        {
            OptionMembers = Open,Approved,Rejected,"Return To Bank";
            DataClassification = CustomerContent;
            Caption = 'Approval Status';
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                case "Approval Status" of
                    "Approval Status"::Approved:
                        begin
                            TestField(BankRecEffortExhausted, true);
                            TestField("Payable Amount");

                        end;
                    "Approval Status"::Rejected:
                        begin

                        end;
                    "Approval Status"::"Return To Bank":
                        begin
                            TestField(BankRecEffortExhausted, false);
                        end;
                end;


            end;
        }


        field(40; Paid; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Paid';
            Editable = false;
        }
        field(41; "SalesPerson Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BDS/BDO';
            TableRelation = "Salesperson/Purchaser";
        }
        field(42; "Approved Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Approved Amount" > "Payable Amount" then
                    Error('Approved amount can not be greater than payable amount');
            end;
        }
        field(43; BankRecEffortExhausted; Boolean)
        {
            Caption = 'Are Bank Recovery Efforts Exhausted?';
        }
        field(44; "Reason For Default"; Code[30])
        {
            TableRelation = "Default Reasons"."Reasons For Default";
        }
        field(45; "Additional Infor on Default"; text[1000])
        {

        }
        field(46; "Reason for Rejection"; Text[100])
        {

        }
        field(47; "Client No."; Code[20])
        {
            TableRelation = Customer."No.";
            Editable = false;
        }
        field(48; Completed; Boolean)
        {
            Editable = false;
        }
        field(49; "Claim Steps"; Option)
        {
            Editable = false;
            OptionMembers = "Mgmt Approval","Board Approval";
        }
        field(50; "Board Status"; Option)
        {
            OptionMembers = Open,Approved,Rejected;
            Editable = false;
        }
        field(51; "Board Meeting Number"; code[20])
        {

        }
        field(52; "Board Meeting Date"; Date)
        {

        }

    }
    keys
    {
        key(PK; "Claim No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

        ContractRec: Record "Guarantee Contracts";
        GuaranteeSource: Record "Credit Guarantee Partner";
        BankRecoveryLines: Record "Bank Recovery Lines";

    trigger OnInsert()
    begin

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
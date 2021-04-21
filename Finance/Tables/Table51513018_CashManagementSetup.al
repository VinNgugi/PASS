table 51513018 "Cash Management Setup"
{
    // version FINANCE

    //LookupPageID = 50006;
    Caption = 'Cash Management Setup';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Payment Voucher Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(3; "Imprest Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(4; "Imprest Surrender Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(5; "Petty Cash Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(6; "Receipt Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(7; "Post VAT"; Boolean)
        {
        }
        field(8; "Rounding Type"; Option)
        {
            OptionCaption = 'Up,Nearest,Down';
            OptionMembers = Up,Nearest,Down;
        }
        field(9; "Rounding Precision"; Decimal)
        {
        }
        field(10; "Imprest Limit"; Decimal)
        {
        }
        field(11; "Imprest Reconciliation Account"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(12; "Imprest Due Date"; DateFormula)
        {
        }
        field(13; "Petty Cash Limit"; Decimal)
        {
        }
        field(14; "PettyC Reconciliation Account"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(15; "Petty Cash Due Date"; DateFormula)
        {
        }
        field(16; "Post PAYEE"; Boolean)
        {
        }
        field(17; "Check Petty Cash Debit Balance"; Boolean)
        {
        }
        field(18; "Use Budget and Commit Setup"; Boolean)
        {
        }
        field(19; "Donor's Income Account"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(20; "Donor Accounting"; Boolean)
        {
        }
        field(21; "Finance Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2),
                                                          "Dimension Value Type" = FILTER (Standard));

            trigger OnValidate();
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");

                /*PurchaseReqDet.RESET;
                PurchaseReqDet.SETRANGE(PurchaseReqDet."Requistion No.","Requisition No.");
                
                IF PurchaseReqDet.FIND('-') THEN  BEGIN
                REPEAT
                PurchaseReqDet."Global Dimension 2 Code":="Global Dimension 2 Code";
                PurchaseReqDet.MODIFY;
                UNTIL PurchaseReqDet.NEXT=0;
                 END;
                 */

            end;
        }
        field(22; "Imprest Accountant"; Code[100])
        {
            TableRelation = "User Setup";
        }
        field(23; "Finance Email"; Text[50])
        {
        }
        field(24; "Petty Cash-Imprest Deduction"; Code[20])
        {
            //TableRelation = Deductions;
        }
        field(25; "Finance Admin"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(26; "Except from Activity"; Text[250])
        {
        }
        field(27; "Except Series From Activity"; Text[250])
        {
        }
        field(28; "Receipt No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(29; "Salary Advace"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(30; "Memo- Salary Advance Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(31; "Imprest Posting Group"; Code[20])
        {
            Caption = 'Imprest Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Customer Posting Group";
        }
        field(32; "General Bus. Posting Group"; code[20])
        {
            DataClassification = CustomerContent;
            caption = 'General Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(33; "VAT Bus. Posting Group"; code[20])
        {
            DataClassification = CustomerContent;
            caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(34; "Bank Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(35; "Petty Cash Replenishment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}


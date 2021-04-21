table 51513999 Banks
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(2; "Bank Code"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No." WHERE("Customer Posting Group" = CONST('BANKS'));
            trigger OnValidate()
            var
                bankRec: Record Customer;
                Contract: record "Guarantee Contracts";
            begin
                if bankRec.Get("Bank Code") then begin
                    Contract.Get("No.");
                    "Bank Name" := bankRec.Name;
                    "Bank Address" := bankRec.Address;
                    "Bank Address 2" := bankRec."Address 2";
                    "Bank Contact No." := bankRec."Phone No.";
                    "Bank Email Address" := bankRec."E-Mail";
                    "Bank Contact Person" := bankRec.Contact;
                    Branch := Contract."Bank Branch";
                end else begin
                    "Bank Name" := '';
                    "Bank Address" := '';
                    "Bank Address 2" := '';
                    "Bank Contact No." := '';
                    "Bank Email Address" := '';
                    "Bank Contact Person" := '';
                end;
            end;
        }
        field(3; "Bank Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; Branch; Text[50])
        {
            DataClassification = CustomerContent;

        }
        field(5; "Approved"; Boolean)
        {

        }
        field(50110; "Bank Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Address';
            Editable = false;
        }
        field(50111; "Bank Address 2"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Address 2';
            Editable = false;
        }
        field(50112; "Bank Contact No."; Text[30])
        {
            DataClassification = CustomerContent;

            ExtendedDatatype = PhoneNo;
        }
        field(50113; "Bank Email Address"; Text[50])
        {
            DataClassification = CustomerContent;

            ExtendedDatatype = EMail;
        }
        field(50115; "Bank Contact Person"; text[50])
        {
            Caption = 'Bank Contact Person';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "No.", "Bank Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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
table 51513951 "My Contracts"
{
    DataClassification = CustomerContent;
    Caption = 'My Contracts';
    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";

        }
        field(2; "Contract No."; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Guarantee Contracts";
            NotBlank = true;

            trigger onvalidate()

            begin
                SetContractFields();
            end;
        }
        field(3; Name; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Phone No."; Text[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "CGC Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "CGC Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "User ID", "Contract No.")
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

    procedure SetContractFields()
    var
        contract: Record "Guarantee Contracts";
    begin
        if contract.Get("Contract No.") then begin
            Name := contract.Name;
            "Phone No." := contract."Phone No.";
            "CGC Amount" := contract."CGC Amount";
            "CGC Expiry Date" := contract."CGC Expiry Date";
        end;
    end;

}
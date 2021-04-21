table 51513027 "Application Required Documents"
{
    DataClassification = CustomerContent;
    Caption = 'Application Required Documents';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            TableRelation = "Guarantee Application"."No.";
            trigger OnValidate()
            var
                Rec: Record "Guarantee Application";

            begin
                if Rec.Get("No.") then
                    "Business Ownership" := Rec."Business Ownership Type";

            end;
        }
        field(2; "Line No."; integer)
        {
            DataClassification = CustomerContent;
            caption = 'Line No.';

        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            TableRelation = "Required Documents".Description where (Code = field ("Business Ownership"));

            trigger OnValidate()
            var
                Req: Record "Required Documents";

            begin
                Req.Reset;
                Req.SetRange(Description, Description);
                Req.SetRange(Code, "Business Ownership");
                if Req.FindFirst then
                    Mandatory := req.Mandatory;
            end;

        }
        field(4; Mandatory; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Mandatory';
            Editable = false;
        }
        field(5; Attached; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Attached';
            Editable = false;
        }
        field(6; "Business Ownership"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Ownership';

        }
        field(7; "Document Link"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Link';
            ExtendedDatatype = URL;
            trigger OnValidate()

            begin
                IF "Document Link" <> '' THEN
                    Attached := true
                else
                    Attached := false;
            end;
        }
    }

    keys
    {
        key(PK; "No.", "Business Ownership", Description)
        {

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
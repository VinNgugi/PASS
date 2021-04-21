table 51513809 "Service Type Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Service No"; Code[20])
        {
            TableRelation = "Services Types"."Service No";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ServiceTypes.Get("Service No") then begin
                    "Service Name" := ServiceTypes."Service Name";
                end else
                    "Service Name" := '';
            end;
        }
        field(3; "Service Name"; Text[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Application ID", "Service No")
        {
            Clustered = true;
        }
    }

    var
        ServiceTypes: Record "Services Types";

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
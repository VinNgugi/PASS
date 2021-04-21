table 51513806 "Enterprenuership Test Entry"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application ID"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;

        }
        field(2; "Test Code"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            var
                EntTestSetup: Record "Enterprenuership Test";
            begin
                if EntTestSetup.Get("Test Code") then begin
                    "Test Question" := EntTestSetup."Test Question";
                end;
            end;
        }
        field(3; "Test Question"; Text[1000])
        {
            Editable = false;
        }
        field(4; "Option Code"; Code[20])
        {
            TableRelation = "Enterprenuership Test Options"."Option Code" where ("Test Code" = field ("Test Code"));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TestOptions.Reset();
                TestOptions.SetRange("Option Code", Rec."Option Code");
                if TestOptions.Find('-') then begin
                    "Option Text" := TestOptions."Option Text";
                    Points := TestOptions."Weighted Score";
                end
                else begin
                    "Option Text" := '';
                    Points := 0;
                end;
            end;
        }
        field(5; "Option Text"; Text[1000])
        {
            Editable = false;
        }
        field(6; "Points"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Application ID", "Test Code")
        {
            Clustered = true;
        }
    }

    var
        TestOptions: Record "Enterprenuership Test Options";

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
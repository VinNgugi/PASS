table 51513813 "WIF Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "Document Date"; Date)
        {
            Editable = false;
        }
        field(4; Selection; Option)
        {
            Editable = false;
            OptionMembers = " ","Business Skills","Technical Training","Face to Face Interviews";
        }
        field(5; "Trainer Name"; Text[50])
        {

        }
        field(6; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(7; "Selection Start Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Gender = Gender::" " then
                    Error('Please Specify the gender of the Trainer');
            end;
        }
        field(8; "Selection End Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Gender = Gender::" " then
                    Error('Please Specify the gender of the Trainer');
            end;
        }
        field(9; "Created By"; Code[20])
        {
            Editable = false;
        }
        field(10; "AIC Job No."; Code[20])
        {
            TableRelation = "Recruitment Needs"."No." where ("Dept Requisition Type" = filter ("AIC Emp"));

            trigger OnValidate()
            var
                myInt: Integer;
            begin

                /*SelectionLines.Reset();
                SelectionLines.SetRange("Document No", "No.");
                SelectionLines.SetRange(Selection, Rec.Selection);
                if SelectionLines.FindSet() then
                    SelectionLines.DeleteAll();

                Applicants.Reset();
                Applicants.SetRange("Job ID", "AIC Job No.");
                Applicants.SetRange("Resident Selection", true);
                if Applicants.FindSet() then
                    repeat
                        with SelectionLines do begin
                            Init();
                            "Document No" := "No.";
                            "Applicant No." := Applicants."No.";
                            "First Name" := Applicants."First Name";
                            "Middle Name" := Applicants."Middle Name";
                            "Last Name" := Applicants."Last Name";
                            Selection := Rec.Selection;
                            Insert();
                        end;
                    until Applicants.Next() = 0;
*/
            end;
        }

    }

    keys
    {
        key(PK; "No.")
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
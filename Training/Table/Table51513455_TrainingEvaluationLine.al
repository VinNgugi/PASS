table 51513455 "Training Evaluation Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "Employee No"; Code[20])
        {
            Editable = false;
        }
        field(3; "Evaluation Area"; Code[50])
        {
            Editable = false;
        }
        field(4; "Evaluation Question"; Text[500])
        {
            Editable = false;
        }
        field(5; "Evaluation Option"; Option)
        {
            OptionMembers = " ",Poor,Fair,Average,Good,Excellent;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Evaluation Points" := 0;

                case "Evaluation Option" of
                    "Evaluation Option"::" ":
                        begin
                            "Evaluation Points" := 0;
                        end;
                    "Evaluation Option"::Poor:
                        begin
                            "Evaluation Points" := 1;
                        end;
                    "Evaluation Option"::Fair:
                        begin
                            "Evaluation Points" := 2;
                        end;
                    "Evaluation Option"::Average:
                        begin
                            "Evaluation Points" := 3;
                        end;
                    "Evaluation Option"::Good:
                        begin
                            "Evaluation Points" := 4;
                        end;
                    "Evaluation Option"::Excellent:
                        begin
                            "Evaluation Points" := 5;
                        end;
                end;
            end;
        }
        field(6; "Evaluation Points"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Header No.", "Evaluation Area")
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
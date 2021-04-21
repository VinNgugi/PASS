table 51513810 "Residential Selection Header"
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
        field(5; "Instructor Name"; Text[50])
        {
            Caption = 'Instructor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup (Resource.Name where ("No." = Field ("Instructor Resource No."),
                                                      Type = const (Person)));
            Editable = false;
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
        field(10; "Incubation Code"; Code[20])
        {
            TableRelation = Incubation where (Status = filter (Released));

            trigger OnValidate()
            var
                IncuRec: Record Incubation;
            begin
                if IncuRec.get("Incubation Code") then begin
                    "Global Dimension 1 Code" := IncuRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := IncuRec."Global Dimension 2 Code";
                    "Global Dimension 4 Code" := IncuRec."Global Dimension 4 Code";

                    SelectionLines.Reset();
                    SelectionLines.SetRange("Document No", "No.");
                    SelectionLines.SetRange(Selection, Rec.Selection);
                    if SelectionLines.FindSet() then
                        SelectionLines.DeleteAll();

                    Applicants.Reset();
                    Applicants.SetRange("Incubation Code", "Incubation Code");
                    Applicants.SetRange("Resident Selection", true);
                    if Applicants.FindSet() then
                        repeat
                            with SelectionLines do begin
                                Init();
                                "Document No" := "No.";
                                "Applicant No." := Applicants."No.";
                                "First Name" := Applicants.Name;
                                "Global Dimension 4 Code" := Applicants."Global Dimension 4 Code";
                                "Global Dimension 1 Code" := Applicants."Global Dimension 1 Code";
                                "Global Dimension 2 Code" := Applicants."Global Dimension 2 Code";
                                Selection := Rec.Selection;
                                Insert();
                            end;
                        until Applicants.Next() = 0;
                end;
            end;
        }
        field(11; Status; Option)
        {
            OptionMembers = " ",Inprogress,Assessment,Closed;
        }
        field(12; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            TableRelation = Resource where (Type = const (Person));

            trigger OnValidate();
            begin
                CalcFields("Instructor Name");
            end;
        }
        field(17; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
            CaptionClass = '1,1,1';
            Editable = false;
        }
        field(18; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
            CaptionClass = '1,1,2';
            Editable = false;


        }
        field(19; "Global Dimension 4 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4));
            CaptionClass = '1,2,4';
            Editable = false;

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
        Applicants: Record "Incubation Applicants";
        SelectionLines: Record "Residential Selection Lines";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        //*************************Insert Application ID
        IF "No." = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Residential Selection Nos");
            NoSeriesMgt.InitSeries(HRSetup."Residential Selection Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        //*************************Insert Application ID
        //*************************Insert Defaults
        "Document Date" := Today;
        "Created By" := UserId;
        //*************************Insert Defaults
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
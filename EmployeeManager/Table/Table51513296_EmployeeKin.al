table 51513296 "Employee Kin"
{
    // version HR
    DataClassification = CustomerContent;
    Caption = 'Employee Relative';

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; Relationship; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Relative";
        }
        field(3; SurName; Text[50])
        {
            NotBlank = true;
        }
        field(4; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
        field(5; "ID No/Passport No"; Text[50])
        {
        }
        field(6; "Date Of Birth"; Date)
        {
        }
        field(7; Occupation; Text[100])
        {
        }
        field(8; Address; Text[250])
        {
        }
        field(9; "Office Tel No"; Text[100])
        {
        }
        field(10; "Home Tel No"; Text[50])
        {
        }
        field(11; Remarks; Text[250])
        {
        }
        field(12; Email; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Percentage Benefit"; Decimal)
        {
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; "Employee Code", SurName, "Other Names")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SETRANGE("Table Name", HRCommentLine."Table Name"::"Employee Relative");
        HRCommentLine.SETRANGE("No.", "Employee Code");
        HRCommentLine.DELETEALL;
    end;

    trigger OnInsert();
    begin
        /*  HRSetup.GET();
          HRSetup.TESTFIELD("Max Next of Kin No.");

          if EmpRec.GET("Employee Code") then begin
              EmpRec.CALCFIELDS("No of Next of Kin");
              if EmpRec."No of Next of Kin" >= HRSetup."Max Next of Kin No." then
                  ERROR('Next of kin can not be more than %1', HRSetup."Max Next of Kin No.");
          end;*/
    end;

    var
        KinCount: Integer;
        HRSetup: Record "Human Resources Setup";
        EmpRec: Record Employee;
}


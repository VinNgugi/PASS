table 51513246 "Company Jobs"
{
    DataClassification = CustomerContent;
    Caption = 'Company Jobs';
    DrillDownPageId = "Company Job List";
    LookupPageId = "Company Job List";

    fields
    {
        field(1; "Job ID"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';
            NotBlank = true;
        }
        field(2; "Job Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Description';
        }
        field(3; "No. of Posts"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Posts';

            trigger OnValidate()

            begin
                IF "No. of Posts" <> xRec."No. of Posts" then
                    "Vacant Establishments" := "No. of Posts" - "Occupied Establishments";
            end;
        }
        field(4; "Position Reporting To"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Position Reporting To';
            TableRelation = "Company Jobs"."Job ID";
        }
        field(5; "Occupied Establishments"; Integer)
        {
            Caption = 'Occupied Establishments';
            FieldClass = FlowField;
            CalcFormula = Count (Employee WHERE (Position = FIELD ("Job ID"), Status = CONST (Active)));
        }
        field(6; "Vacant Establishments"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Vacant Establishments';
        }
        field(7; "Score Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Score Code';
        }
        field(8; "Dimension 1"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 1';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

        }
        field(9; "Dimension 2"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 2';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

        }
        field(10; "Dimension 3"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 3';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));

        }
        field(11; "Dimension 4"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 4';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4));

        }
        field(12; "Dimension 5"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 1';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (5));

        }
        field(13; "Dimension 6"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 6';
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (6));

        }
        field(14; "Dimension 7"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 7';
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));

        }
        field(15; "Dimension 8"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 8';
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (8));

        }
        field(16; Grade; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade';
            TableRelation = "Salary Scales";
        }
        field(17; "Notice Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Notice Period';
        }
        field(18; "Probation Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Probation Period';
        }
        field(19; "Date Active"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Active';
        }
        field(20; "Status"; Option)
        {
            OptionMembers = Active,Inactive;
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(21; "No of Position"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Position';
        }
        field(22; "Total Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Job Requirement"."Score ID" WHERE ("Job Id" = FIELD ("Job ID")));
            Caption = 'Total Score';
            Editable = false;
        }
        field(23; "Stage filter"; Integer)
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value";
            Caption = 'Stage filter';
        }
        field(24; Objective; Text[250])
        {
            Caption = 'Objective';
            DataClassification = CustomerContent;
        }
        field(25; "Key Position"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Key Position';
        }
        field(26; Category; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
        }
        field(27; Management; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Management';
        }
        field(28; Variance; Integer)
        {
            DataClassification = CustomerContent;
            caption = 'Variance';
        }
        field(29; "Job Funcion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Pass Job","AIC Job";
        }
        field(30; "Incubation Name"; Text[50])
        {

        }
        field(31; "Incubation Type"; Code[20])
        {

        }
        field(33; "Incubation Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "Incubation End Date" := CalcDate("Incubation Period", "Incubation Start Date");
            end;
        }
        field(34; "Incubation End Date"; Date)
        {
            Editable = false;
        }
        field(35; "Incubation Period"; DateFormula)
        {
            trigger OnValidate()
            begin
                "Incubation End Date" := CalcDate("Incubation Period", "Incubation Start Date");
            end;
        }
    }
    keys
    {
        key(JobID; "Job ID")
        {

        }
        key(vacant; "Vacant Establishments")
        {

        }
        key(Dim1; "Dimension 1")
        {

        }
        key(Dim2; "Dimension 2")
        {

        }
        key(JobDesc; "Job Description")
        {

        }
    }
    trigger OnDelete()
    begin
        Error('Delete not allowed');
    end;


}
table 51513240 "Objective Performance Measures"
{
    // version HR

    Caption = 'Objective Performance Measures';
    DataClassification = CustomerContent;
    fields
    {
        field(1; MeasureID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; ObjectiveID; Integer)
        {
        }
        field(3; "Measure Description"; Text[100])
        {
        }
        field(4; Targets; Text[100])
        {
            Caption = 'Current Year Targets';
        }
        field(5; Initiatives; Text[100])
        {
            Caption = 'Current Year Actuals';
        }
        field(6; "Review Comments"; Text[100])
        {
        }
        field(7; "Weighting(%)"; Decimal)
        {
        }
        field(8; "Performance Ratings"; Decimal)
        {

            trigger OnValidate();
            begin
                TESTFIELD("Weighting(%)");
                "Weighted Ratings" := ("Performance Ratings" / 100) * "Weighting(%)";
            end;
        }
        field(9; "Weighted Ratings"; Decimal)
        {
        }
        field(10; "Appraisal No"; Code[20])
        {
        }
        field(11; Approved; Boolean)
        {
        }
        field(12; "Appraisal Period Target"; Text[100])
        {

        }
        field(13; "Appraisal Period Actuals"; Text[100])
        {

        }
        field(14; "Five-Year Targets"; Text[100])
        {
            Caption = 'Current Five-Year Targets';
        }
    }

    keys
    {
        key(Key1; MeasureID, ObjectiveID, "Appraisal No")
        {
            SumIndexFields = "Weighting(%)", "Performance Ratings", "Weighted Ratings";
        }
    }

    fieldgroups
    {
    }
}


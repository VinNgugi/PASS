table 51513452 "Training Participants Lines"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Training Employees List";
    LookupPageId = "Training Employees List";


    fields
    {
        field(1; "Training Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Training Plan"."Request No.";
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                TrainingMgmt.FnCheckIfUserTrainingDatesClash("Employee No.", "Training Header No.", "Training Start Date", "Training End Date");

                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Responsibility Center" := Employee."Responsibility Center";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";

                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            Editable = false;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = filter (1), Blocked = filter (false));
            CaptionClass = '1,1,1';
            Editable = false;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = filter (2), Blocked = filter (false));
            CaptionClass = '1,1,2';
            Editable = false;
        }
        field(7; "Training Start Date"; Date)
        {

        }
        field(8; "Training End Date"; Date)
        {

        }
        field(9; "G/l Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(10; "Budget Code"; Code[20])
        {
            Editable = false;
            TableRelation = "G/L Budget Name".Name;
        }
        field(11; "Budgeted Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("G/L Budget Entry".Amount where ("Budget Name" = field ("Budget Code"), "G/L Account No." = field ("G/l Account"), "Global Dimension 1 Code" = field ("Global Dimension 1 Code")));
        }
        field(12; Commitment; Decimal)
        {
            Editable = false;
        }
        field(13; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       ("Document Date" <> xRec."Document Date") OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate("Document Date", "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;
        }
        field(14; "Currency Factor"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));

                Validate("Per Diem");
                Validate(Accomodation);
                Validate("Air Ticket Fee");
                Validate("Travel Expences");
                Validate("Net Amount");

            end;
        }
        field(15; "Per Diem"; Decimal)
        {

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "Per Diem(LCY)" := "Per Diem"
                ELSE
                    "Per Diem(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Per Diem", "Currency Factor"));

                "Net Amount" := "Per Diem" + Accomodation + "Air Ticket Fee" + "Travel Expences";
                Validate("Net Amount");
            end;
        }
        field(16; Accomodation; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "Accomodation(LCY)" := Accomodation
                ELSE
                    "Accomodation(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", Accomodation, "Currency Factor"));

                "Net Amount" := "Per Diem" + Accomodation + "Air Ticket Fee" + "Travel Expences";
                Validate("Net Amount");
            end;
        }
        field(17; "Air Ticket Fee"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "Air Ticket Fee(LCY)" := "Air Ticket Fee"
                ELSE
                    "Air Ticket Fee(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Air Ticket Fee", "Currency Factor"));

                "Net Amount" := "Per Diem" + Accomodation + "Air Ticket Fee" + "Travel Expences";
                Validate("Net Amount");
            end;
        }
        field(18; "Travel Expences"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "Travel Expences(LCY)" := "Travel Expences"
                ELSE
                    "Travel Expences(LCY)" := ROUND(
                         CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Travel Expences", "Currency Factor"));

                "Net Amount" := "Per Diem" + Accomodation + "Air Ticket Fee" + "Travel Expences";
                Validate("Net Amount");
            end;
        }
        field(19; "Net Amount"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "Net Amount(LCY)" := "Net Amount"
                ELSE
                    "Net Amount(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY("Document Date", "Currency Code", "Net Amount", "Currency Factor"));
            end;
        }
        field(20; "Per Diem(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(21; "Accomodation(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(22; "Air Ticket Fee(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(23; "Travel Expences(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(24; "Net Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(25; "Document Date"; Date)
        {

        }



    }

    keys
    {
        key(PK; "Training Header No.", "Employee No.")
        {
            Clustered = true;
        }
    }

    var
        Text002: TextConst ENU = 'cannot be specified without %1';
        Employee: Record Employee;
        TrainingMgmt: Codeunit "Training Management";
        TrainingPlan: Record "Training Plan";
        CurrExchRate: Record "Currency Exchange Rate";

    trigger OnInsert()
    begin

        TrainingPlan.Reset();
        TrainingPlan.SetRange("Request No.", "Training Header No.");
        if TrainingPlan.Find('-') then begin
            "Training Start Date" := TrainingPlan."Training Start Date";
            "Training End Date" := TrainingPlan."Training End Date";
            "Document Date" := TrainingPlan."Document Date";
            "Budget Code" := TrainingPlan."Budget Code";
            "G/l Account" := TrainingPlan."G/L Account";
            "Currency Code" := TrainingPlan."Currency Code";
            "Currency Factor" := TrainingPlan."Currency Factor";
        end;
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
table 51513237 "Appraisal Objectives Lines"
{
    // version HR
    Caption = 'Appraisal Objectives Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;
        }
        field(2; "Appraisal Type"; Code[20])
        {
        }
        field(3; "Appraisal Period"; Code[20])
        {
        }
        field(4; Objective; Text[120])
        {
            NotBlank = false;
        }
        field(5; "No."; Code[20])
        {
            NotBlank = false;
        }
        field(6; Measure; Text[250])
        {
        }
        field(7; "Agreed Target Date"; Date)
        {
        }
        field(8; "Weighting(%)"; Decimal)
        {

            trigger OnValidate();
            begin
                TotalWeightings := 0;

                Appraisalines.RESET;
                Appraisalines.SETRANGE(Appraisalines."Appraisal No", "Appraisal No");
                Appraisalines.SETRANGE(Appraisalines."Appraisal Heading Type", "Appraisal Heading Type");
                if Appraisalines.FIND('-') then begin
                    repeat
                        TotalWeightings := TotalWeightings + Appraisalines."Weighting(%)";
                    until Appraisalines.NEXT = 0;
                end;

                if (TotalWeightings + "Weighting(%)") > 100 then
                    ERROR('You are not allowed to enter Weightings(%) more than a total of 100 for %1', "Appraisal Heading Type");
            end;
        }
        field(9; "Review Comments/ Achievements"; Text[250])
        {
        }
        field(10; "Performance Ratings(%)"; Decimal)
        {
        }
        field(11; "Job ID"; Code[20])
        {
            TableRelation = "Company Jobs"."Job ID";
        }
        field(12; "Line No"; Integer)
        {
        }
        field(13; "Appraiser's Comments"; Text[150])
        {
        }
        field(14; "Appraisee's comments"; Text[150])
        {
        }
        field(15; Description; Text[80])
        {
        }
        field(16; "Appraisal Heading Type"; Option)
        {
            OptionCaption = '" ,Finance and Accounting,Project Management,HR Management,Administration"';
            OptionMembers = " ","Finance and Accounting","Project Management","HR Management",Administration;
        }
        field(17; "Appraisal Header"; Text[50])
        {
            TableRelation = "Appraisal Format Header";
        }
        field(18; Bold; Boolean)
        {
        }
        field(19; "Appraisal No"; Code[20])
        {
        }
        field(20; "New No."; Integer)
        {
            AutoIncrement = false;
        }
        field(21; Dropped; Boolean)
        {
        }
        field(22; "Strategic Perspective"; Option)
        {
            OptionCaption = 'Financial,Stakeholder,Internal Business Process,Learning and Growth';
            OptionMembers = Financial,Stakeholder,"Internal Business Process","Learning and Growth";
        }
        field(23; "Weighted Ratings(%)"; Decimal)
        {
        }
        field(24; Approved; Boolean)
        {
        }
        field(25; "Resources Required"; Text[250])
        {
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

            trigger OnValidate();
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");

                /*PurchaseReqDet.RESET;
                PurchaseReqDet.SETRANGE(PurchaseReqDet."Requistion No.","Requisition No.");
                
                f IF PurchaseReqDet.FIND('-') THEN BEGIN
                REPEAT
                PurchaseReqDet."Global Dimension 1 Code":="Global Dimension 1 Code";
                PurchaseReqDet.MODIFY;
                UNTIL PurchaseReqDet.NEXT=0;
                END;
                
                PurchaseReqDet.VALIDATE(PurchaseReqDet."No."); */

            end;
        }
        field(27; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

            trigger OnValidate();
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");

                /*PurchaseReqDet.RESET;
                PurchaseReqDet.SETRANGE(PurchaseReqDet."Requistion No.","Requisition No.");
                
                IF PurchaseReqDet.FIND('-') THEN  BEGIN
                REPEAT
                PurchaseReqDet."Global Dimension 2 Code":="Global Dimension 2 Code";
                PurchaseReqDet.MODIFY;
                UNTIL PurchaseReqDet.NEXT=0;
                 END;*/

            end;
        }
    }

    keys
    {
        key(Key1; "Appraisal No", "Line No")
        {
        }
        key(Key2; "Employee No", "Appraisal Type", "Line No")
        {
        }

    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //MESSAGE('%1',GetNextLine);
        "Line No" := GetNextLine;
    end;

    var
        Appraisalines: Record "Appraisal Objectives Lines";
        TotalWeightings: Decimal;

    procedure GetNextLine() NxtLine: Integer;
    var
        AppraisalLine: Record "Appraisal Objectives Lines";
    begin
        AppraisalLine.RESET;
        AppraisalLine.SETRANGE(AppraisalLine."Appraisal No", "Appraisal No");
        if AppraisalLine.FIND('+') then
            NxtLine := AppraisalLine."Line No" + 1000;
    end;
}


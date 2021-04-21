table 51513229 "Departmental Objectives"
{
    // version HR


    fields
    {
        field(1; Period; Code[20])
        {
            NotBlank = true;
            TableRelation = "Appraisal Periods".Period;
        }
        field(3; "Global Dimension 2 Code"; Code[20])
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
        field(19; "Appraisee's Job Title"; Text[100])
        {
        }
        field(20; Type; Option)
        {
            OptionMembers = ,General,Workplan;
        }
        field(21; Employee; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(23; Objective; Text[200])
        {
            Editable = true;
            TableRelation = IF (Type = CONST (Workplan)) "Dimension Value".Name WHERE ("Dimension Code" = CONST ('WORKPLAN'));
        }
        field(28; "Line no"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Period, Employee, "Line no")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        /*ptarget.RESET;
        ptarget.SETFILTER(ptarget.Period,Period);
        ptarget.SETFILTER(ptarget.Employee,Employee);
        IF ptarget.FINDLAST THEN BEGIN
            //MESSAGE('%1',"Line no");
            "Line no":=ptarget."Line no"+10;
        END;
        */

    end;

    var
        KPAreas: Record "Key Performance Areas";
        //ptarget : Record Applicants;

    local procedure newrec();
    begin
        Period := Period;
        Employee := Employee;
    end;
}


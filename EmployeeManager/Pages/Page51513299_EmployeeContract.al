page 51513299 "Employee Contract"
{
    // version HR

    PageType = Card;
    SourceTable = "Employee Contracts";
    Caption = 'Employee Contract';
    layout
    {
        area(content)
        {
            field("Employee No"; "Employee No")
            {
            }
            field("Employee Name"; "Employee Name")
            {
            }
            field("Contract No"; "Contract No")
            {
            }
            field("Contract Start Date"; "Contract Start Date")
            {
            }
            field("Contract Period"; "Contract Period")
            {
            }
            field("Contract End Date"; "Contract End Date")
            {
            }
            field("Contract Leave Entitlement"; "Contract Leave Entitlement")
            {
            }
            field("Balance Brought Forward"; "Balance Brought Forward")
            {
            }
            field("Contract Leave Balance"; "Contract Leave Balance")
            {
            }
            field(Status; Status)
            {
                Editable = FALSE;
            }
            field("Requires Probation"; "Requires Probation")
            {

                trigger OnValidate();
                begin
                    Showhide := true;
                end;
            }
            field("Probation Period"; "Probation Period")
            {
                Visible = Showhide;
            }
            field("Probation End Date"; "Probation End Date")
            {
                Visible = Showhide;
            }
            field("Probation Leave Days"; "Probation Leave Days")
            {
                Visible = Showhide;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Contract")
            {
                Caption = 'Create Contract';
                Enabled = true;
                Image = Answers;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction();
                begin
                    /*IF NOT Created THEN BEGIN
                    IF Emp.GET("Employee No") THEN BEGIN
                      IF Emp."Contract Number" <> '' THEN BEGIN
                      IF Contract.GET(Emp."Contract Number") AND (Contract.Status = Contract.Status::Active) THEN
                         ERROR(Text001,"Employee No",Emp."Contract Number")
                      END;
                    
                      Emp."Contract Number":="Contract No";
                      Emp."Contract Status":=Status;
                      Emp."Contract Start Date":="Contract Start Date";
                      Emp."Contract End Date":="Contract End Date";
                      Emp.MODIFY(TRUE);
                    
                      Created:=TRUE;
                      MODIFY;
                      MESSAGE(Text004,"Contract No");
                    END;
                    END ELSE
                    ERROR(Text002);
                    */

                end;
            }
            action("Terminate Contract")
            {
                Caption = 'Terminate Contract';
                Enabled = true;
                Image = AutofillQtyToHandle;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction();
                begin
                    /*IF Created THEN BEGIN
                    IF CONFIRM(Text003,TRUE) = FALSE THEN
                    EXIT;
                    IF Emp.GET("Employee No") THEN BEGIN
                      IF Emp."Contract Number" = "Contract No" THEN BEGIN
                      Emp."Contract Status":= Emp."Contract Status"::Terminated;
                      Emp.MODIFY(TRUE);
                      END;
                    "Termination Date":=TODAY;
                    Status:=Status::Terminated;
                    MODIFY;
                    MESSAGE(Text005,"Contract No");
                    END;
                    END;
                    */

                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        OnAfterGetCurrRecord;
    end;

    var
        D: Date;
        EmpLeaveApps: Record "Employee Contracts";
        EmpOffs: Record "Employee Leave Plan";
        EmpAbsence: Record "Applicants Qualification";
        TotalDays: Decimal;
        Absent: Decimal;
        Recalled: Decimal;
        Emp: Record Employee;
        Contract: Record "Employee Contracts";
        Text001: Label 'The Employee No. %1 has an active Contract No.%2';
        Text002: Label 'The Contract has already been created';
        Text003: Label 'Are you sure you want to Terminate this Contract';
        Text004: Label 'Contract No. %1 has been Created';
        Text005: Label 'Contract No. %1 has been Terminated';
        [InDataSet]
        Showhide: Boolean;

    local procedure ContractEndDateOnAfterValidate();
    begin
        VALIDATE("Contract End Date");
    end;

    local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        if (Status = Status::Expired) or (Status = Status::Terminated) then begin
            CurrPage.EDITABLE := false;
        end else
            CurrPage.EDITABLE := true;
        /*
        //Calculate leave entitlement for the contract period
          // MESSAGE('End Date %1',"Contract End Date");
          VALIDATE("Contract Start Date");
          VALIDATE("Contract End Date");
          IF ("Contract End Date"<>0D) AND ("Contract Start Date"<>0D) THEN
             "Contract Leave Entitlement":=ROUND(((("Contract End Date"-"Contract Start Date")/30)*2.5),1);
        
           TotalDays:=0;
           Recalled:=0;
           Absent:=0;
        
        
        //Calculate avilable Leave Balance
           EmpLeaveApps.RESET;
           EmpLeaveApps.SETRANGE(EmpLeaveApps."Employee No","Employee No");
           EmpLeaveApps.SETRANGE(EmpLeaveApps."Leave Code",'ANNUAL');
           EmpLeaveApps.SETRANGE(EmpLeaveApps."Start Date","Contract Start Date","Contract End Date");
           //EmpLeaveApps.SETRANGE(EmpLeaveApps."End Date","Contract Start Date","Contract End Date");
           EmpLeaveApps.SETRANGE(EmpLeaveApps.Status,EmpLeaveApps.Status::Released);
          // EmpLeaveApps.CALCFIELDS(EmpLeaveApps."Days Applied");
           IF EmpLeaveApps.FIND('-') THEN BEGIN
           REPEAT
               TotalDays:=TotalDays+EmpLeaveApps."Days Applied";
           UNTIL EmpLeaveApps.NEXT=0;
            END;
        
            EmpOffs.RESET;
            EmpOffs.SETRANGE(EmpOffs."Employee No","Employee No");
            EmpOffs.SETRANGE(EmpOffs."Recalled From","Contract Start Date","Contract End Date");
           // EmpOffs.SETRANGE(EmpOffs."Recalled To","Contract Start Date","Contract End Date");
            IF EmpOffs.FIND('-') THEN BEGIN
            REPEAT
               Recalled:=Recalled+EmpOffs."No. of Off Days";
            UNTIL EmpOffs.NEXT=0;
             END;
        
            EmpAbsence.RESET;
            EmpAbsence.SETRANGE(EmpAbsence."Employee No","Employee No");
            EmpAbsence.SETRANGE(EmpAbsence."Absent From","Contract Start Date","Contract End Date");
            //EmpAbsence.SETRANGE(EmpAbsence."Absent To","Contract Start Date","Contract End Date");
            IF EmpAbsence.FIND('-') THEN BEGIN
            REPEAT
             Absent:=Absent+EmpAbsence."No. of  Days Absent";
            UNTIL EmpAbsence.NEXT=0;
            END;
        
        "Contract Leave Balance":=("Contract Leave Entitlement"+"Balance Brought Forward"+Recalled)-(TotalDays+Absent);
         */

    end;
}


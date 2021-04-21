page 51513161 "Emplo Leave Application List"
{
    // version HR

    Caption = 'Employee Leave Applications List';
    CardPageID = "Leave Application HR";
    PageType = List;
    SourceTable = "Employee Leave Application";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Employee No"; "Employee No")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Application No"; "Application No")
                {
                }
                field("Leave Code"; "Leave Code")
                {
                }
                field("Days Applied"; "Days Applied")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field("Application Date"; "Application Date")
                {
                }
                field("Approved Days"; "Approved Days")
                {
                }
                field("Leave Status"; "Leave Status")
                {
                }
                field("Approved End Date"; "Approved End Date")
                {
                }
                field("Approval Date"; "Approval Date")
                {
                }
                field("Leave Allowance Payable"; "Leave Allowance Payable")
                {
                }
                field(days; days)
                {
                }
                field("No. series"; "No. series")
                {
                }
                field("Resumption Date"; "Resumption Date")
                {
                }
                field(Status; Status)
                {
                    Editable = true;
                }
                field("Balance brought forward"; "Balance brought forward")
                {
                }
                field("Leave Entitlment"; "Leave Entitlment")
                {
                }
                field("Recalled Days"; "Recalled Days")
                {
                }
                field("Total Leave Days Taken"; "Total Leave Days Taken")
                {
                }
                field("Days Absent"; "Days Absent")
                {
                }
                field("Leave balance"; "Leave balance")
                {
                }
                field("Acting Person"; "Acting Person")
                {
                }
                field(Name; Name)
                {
                }
                field("Annual Leave Entitlement Bal"; "Annual Leave Entitlement Bal")
                {
                }
                field("Mobile No"; "Mobile No")
                {
                }
                field("Approved Start Date"; "Approved Start Date")
                {
                }
                field("Leave Earned to Date"; "Leave Earned to Date")
                {
                }
                field("Maturity Date"; "Maturity Date")
                {
                }
                field("Date of Joining Company"; "Date of Joining Company")
                {
                }
                field("Fiscal Start Date"; "Fiscal Start Date")
                {
                }
                field("No. of Months Worked"; "No. of Months Worked")
                {
                }
                field("Off Days"; "Off Days")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("User ID"; "User ID")
                {
                }
                field("Contract No."; "Contract No.")
                {
                }
            }
        }
    }


    /*
        trigger OnOpenPage();
        begin
            usersetup.RESET;
            if usersetup.GET(USERID) then begin
                emprec.RESET;
                if emprec.GET(usersetup."Employee No.") then begin
                    SETRANGE("Employee No", emprec."No.");
                end;
            end;
        end;
    */
    var
        usersetup: Record "User Setup";
        emprec: Record Employee;
}

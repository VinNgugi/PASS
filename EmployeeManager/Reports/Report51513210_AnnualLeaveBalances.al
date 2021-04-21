report 51513210 "Leave Balances"
{

    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Annual Leave Balances.rdl';
    Caption = 'Annual Leave Balances';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name; Name)
            {

            }
            column(Picture; Picture)
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Home_Page; "Home Page")
            {

            }
            column(Address; Address)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            dataitem(Employee; Employee)
            {
                RequestFilterFields = "No.", "Employee Posting Group";
                column(No; "No.")
                {
                }
                column(FirstName; "First Name")
                {
                }
                column(LastName; "Last Name")
                {
                }
                column(MiddleName; "Middle Name")
                {
                }
                column(Balance_Carried_Forward; "Balance Carried Forward")
                {
                }
                column(TotalLeavedaysAllocated; "Total Leavedays Allocated")
                {
                }
                column(TotalLeavedaysTaken; "Total Leavedays Taken")
                {
                }
                column(Total_Recalled_Days; "Total Recalled Days")
                {
                }
                column(Total_Credited_Back; "Total Credited Back")
                {
                }
                column(LeaveBalance; "Leave Balance")
                {
                }
                column(LeavePeriod; LeavePeriod)
                {
                }

                trigger OnPredataItem()
                var
                    myInt: Integer;
                begin
                    ObjLeaveType.Reset();
                    ObjLeaveType.SetRange("Annual Leave", true);
                    if (Employee."Employee Posting Group" = 'INTERN') or (Employee."Employee Posting Group" = 'TEMP') then
                        ObjLeaveType.SetRange("Eligible Staff", ObjLeaveType."Eligible Staff"::Temporary)
                    else
                        ObjLeaveType.SetRange("Eligible Staff", ObjLeaveType."Eligible Staff"::Both);
                    if ObjLeaveType.Find('-') then begin
                        if LeavePeriod = '' then
                            Error('Please assign a period for which you want to see the leave balances.')
                        else begin
                            ObjLeavePeriod.Reset();
                            ObjLeavePeriod.SetRange("Period Code", LeavePeriod);
                            if ObjLeavePeriod.Find('-') then begin

                                Employee.SetRange("Date Filter", ObjLeavePeriod."Starting Date", ObjLeavePeriod."Ending Date");
                                Employee.SetRange("Leave Type Filter", ObjLeaveType.Code);
                                Employee.CalcFields("Balance Carried Forward", "Total Leavedays Allocated", "Total Leavedays Taken", "Total Recalled Days", "Total Credited Back", "Leave Balance")
                            end
                        end;
                    end;
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnPostDataItem()
                var
                    myInt: Integer;
                begin

                end;
            }
            trigger OnPredataItem()
            var
                myInt: Integer;
            begin
                "Company Information".CalcFields(Picture)
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(LeavePeriod; LeavePeriod)
                    {
                        Caption = 'Leave Period Filter';
                        TableRelation = "HR Leave Periods"."Period Code";
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        LeavePeriod: Code[20];
        ObjLeavePeriod: Record "HR Leave Periods";
        ObjLeaveType: Record "Leave Types";
}

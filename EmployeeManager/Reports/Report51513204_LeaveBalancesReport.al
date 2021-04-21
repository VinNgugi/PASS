report 51513204 "Leave Balances Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leave Balances Report.rdl';
    caption = 'Leave Balances Report';

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
            dataitem(Employee; Employee)
            {
                RequestFilterFields = "No.", "Date Filter", "Leave Type Filter";

                column(No_; "No.")
                {

                }
                column(Last_Name; "Last Name")
                {

                }
                column(First_Name; "First Name")
                {

                }
                column(Middle_Name; "Middle Name")
                {

                }
                column(Date_Filter; "Date Filter")
                {

                }
                column(LeaveCode_1; LeaveCode[1])
                {

                }
                column(LeaveCode_2; LeaveCode[2])
                {

                }
                column(LeaveCode_3; LeaveCode[3])
                {

                }
                column(LeaveCode_4; LeaveCode[4])
                {

                }
                column(LeaveCode_5; LeaveCode[5])
                {

                }
                column(LeaveCode_6; LeaveCode[6])
                {

                }
                column(LeaveCode_7; LeaveCode[7])
                {

                }
                column(LeaveCode_8; LeaveCode[8])
                {

                }
                column(LeaveCode_9; LeaveCode[9])
                {

                }
                column(LeaveCode_10; LeaveCode[10])
                {

                }
                column(LeaveBalance_1; LeaveBalance[1])
                {

                }
                column(LeaveBalance_2; LeaveBalance[2])
                {

                }
                column(LeaveBalance_3; LeaveBalance[3])
                {

                }
                column(LeaveBalance_4; LeaveBalance[4])
                {

                }
                column(LeaveBalance_5; LeaveBalance[5])
                {

                }
                column(LeaveBalance_6; LeaveBalance[6])
                {

                }
                column(LeaveBalance_7; LeaveBalance[7])
                {

                }
                column(LeaveBalance_8; LeaveBalance[8])
                {

                }
                column(LeaveBalance_9; LeaveBalance[9])
                {

                }
                column(LeaveBalance_10; LeaveBalance[10])
                {

                }
                trigger OnPredataItem()
                var
                    myInt: Integer;
                begin
                    if AsAtDate = 0D then
                        AsAtDate := Today;


                    Clear(i);
                    Clear(LeaveCode);
                    Clear(LeaveBalance);

                    ObjLeaveTypes.Reset();
                    if ObjLeaveTypes.FindSet() then
                        repeat
                            i := i + 1;
                            LeaveCode[i] := ObjLeaveTypes.Code;
                        until ObjLeaveTypes.Next() = 0;

                    NoOfLeaves := i;
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Clear(LeaveBalance[i]);
                    for i := 1 to NoOfLeaves do begin

                        SetRange("Leave Type Filter", LeaveCode[i]);
                        CalcFields("Leave Balance");
                        LeaveBalance[i] := "Leave Balance";
                        i := i + 1;
                    end;


                end;
            }
            trigger OnPredataItem()
            var
                myInt: Integer;
            begin
                "Company Information".CalcFields(Picture)
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var

        i: Integer;
        NoOfLeaves: Integer;
        LeaveCode: array[20] of Text[250];
        LeaveBalance: array[20] of Decimal;
        LeaveDesc: array[20] of Text[250];
        ObjLeaveTypes: Record "Leave Types";
        AsAtDate: Date;



}
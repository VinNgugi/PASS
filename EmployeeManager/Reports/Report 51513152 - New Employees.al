report 51513152 "New Employees"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/New Employees.rdl';
    Caption = 'New Employees';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.");
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(STRSUBSTNO__PERIOD___1__UPPERCASE_FORMAT_Thismonth_0___month_text___year4_____; STRSUBSTNO('PERIOD: %1', UPPERCASE(FORMAT(Thismonth, 0, '<month text> <year4>'))))
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(First_Name_______Middle_Name________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Counter; Counter)
            {
            }
            column(NEW_EMPLOYEESCaption; NEW_EMPLOYEESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Hire_Date; Employee."Employment Date")
            {
            }
            column(Contract_End_Date; Employee."Contract End Date")
            {
            }
            /*column(Location; Employee."Global Dimension 6 Code")
            {
            }*/
            column(Centre_ID; Employee."Global Dimension 2 Code")
            {
            }
            column(Old_PG; OldPg)
            {
            }
            column(Old_Centre; OldCentre)
            {
            }

            trigger OnAfterGetRecord();
            begin
                FoundThismonth := false;
                FoundLastmonth := false;

                AssignMat.RESET;
                AssignMat.SETRANGE(AssignMat."Employee No", Employee."No.");
                AssignMat.SETRANGE(AssignMat."Payroll Period", Thismonth);
                if AssignMat.FIND('+') then
                    FoundThismonth := true;


                AssignMat.RESET;
                AssignMat.SETRANGE(AssignMat."Employee No", Employee."No.");
                AssignMat.SETRANGE(AssignMat."Payroll Period", LastMonth);
                if AssignMat.FIND('+') then
                    FoundLastmonth := true;

                if FoundThismonth and FoundLastmonth then
                    CurrReport.SKIP;

                if not FoundThismonth and not FoundLastmonth then
                    CurrReport.SKIP;


                if FoundLastmonth and not FoundThismonth then
                    CurrReport.SKIP;

                Counter := Counter + 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(MonthStartDate; MonthStartDate)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);

        // Thismonth:=Employee.GETRANGEMIN(Employee."Pay Period Filter");
        Thismonth := MonthStartDate;
        LastMonth := CALCDATE('-1M', Thismonth);
    end;

    var
        AssignMat: Record "Assignment Matrix";
        LastMonth: Date;
        Thismonth: Date;
        FoundThismonth: Boolean;
        FoundLastmonth: Boolean;
        Counter: Integer;
        NEW_EMPLOYEESCaptionLbl: Label 'NEW EMPLOYEES';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        MonthStartDate: Date;
        OldPg: Code[10];
        OldCentre: Code[10];
}


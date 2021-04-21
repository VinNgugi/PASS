report 51513153 "Employees Removed"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Employees Removed.rdl';
    Caption = 'Employees Removed';

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
            column(EMPLOYEES_REMOVED_FROM_PAYROLLCaption; EMPLOYEES_REMOVED_FROM_PAYROLLCaptionLbl)
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


                if not FoundLastmonth and FoundThismonth then
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
        EMPLOYEES_REMOVED_FROM_PAYROLLCaptionLbl: Label 'EMPLOYEES REMOVED FROM PAYROLL';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        MonthStartDate: Date;
        OldPg: Code[10];
        OldCentre: Code[10];
}


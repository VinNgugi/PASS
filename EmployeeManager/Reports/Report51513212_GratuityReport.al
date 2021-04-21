report 51513212 "Gratuity Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Gratuity Report.rdl';
    caption = 'Gratuity Report';
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
            column(NSSF_Employer_No; "NSSF Employer No")
            {

            }
            column(Region_Code; "Region Code")
            {

            }
            dataitem(Employee; Employee)
            {
                column(No; "No.")
                {
                }
                column(FirstName; "First Name")
                {
                }
                column(MiddleName; "Middle Name")
                {
                }
                column(LastName; "Last Name")
                {
                }
                column(Gratuity_Accumulated; "Gratuity Accumulated")
                {

                }
                column(Gratuity_Paid_Out; "Gratuity Paid Out")
                {

                }
                column(Contract_Start_Date; "Contract Start Date")
                {

                }
                column(Contract_End_Date; "Contract End Date")
                {

                }
                column(BasicPay; BasicPay)
                {

                }
                column(MonthlyGratuity; MonthlyGratuity)
                {

                }
                column(TotalGratuity; TotalGratuity)
                {

                }
                column(DateFilter; DateFilter)
                {

                }
                trigger OnPredataItem()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    BasicPay := 0;
                    MonthlyGratuity := 0;
                    TotalGratuity := 0;

                    SetRange("Pay Period Filter", DateFilter);
                    CalcFields(Basic);
                    BasicPay := Employee.Basic;


                    datefilter2 := '..' + Format(DateFilter);
                    SetFilter("Pay Period Filter", datefilter2);
                    CalcFields("Gratuity Accumulated", "Gratuity Paid Out");
                    TotalGratuity := Employee."Gratuity Accumulated" - employee."Gratuity Paid Out";

                    AssignMatrix.Reset();
                    AssignMatrix.SetRange("Employee No", Employee."No.");
                    AssignMatrix.SetRange("Payroll Period", DateFilter);
                    AssignMatrix.SetRange(gratuity, true);
                    if AssignMatrix.Find('-') then begin
                        MonthlyGratuity := AssignMatrix."Employer Amount";

                    end;

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
                "Company Information".CalcFields(Picture);

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
                group("Payroll Period")
                {
                    field(DateFilter; DateFilter)
                    {
                        Caption = 'Payroll Period';
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
        DateFilter: Date;
        datefilter2: Text;
        BasicPay: Decimal;
        MonthlyGratuity: Decimal;
        TotalGratuity: Decimal;
        AssignMatrix: Record "Assignment Matrix";
}

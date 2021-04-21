report 51513211 "PAYE Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PAYE Report.rdl';
    Caption = 'PAYE Report';
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
                column(No_; "No.")
                {

                }
                column(First_Name; "First Name")
                {

                }
                column(Middle_Name; "Middle Name")
                {

                }
                column(Last_Name; "Last Name")
                {

                }
                column(NSSF_No_; "NSSF No.")
                {

                }
                column(P_I_N; "P.I.N")
                {

                }
                column(Basic; Basic)
                {

                }
                column(OtherAllowances; OtherAllowances)
                {

                }
                column(Total_Allowances; "Total Allowances")
                {

                }
                column(Total_Deductions; "Total Deductions")
                {

                }
                column(Cumm__PAYE; "Cumm. PAYE")
                {

                }
                column(Taxable_Allowance; "Taxable Allowance")
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
                    ObjDed.Reset();
                    ObjDed.SetRange("PAYE Code", true);
                    if ObjDed.Find('-') then begin
                        Employee.SetRange("Date Filter", DateFilter);
                        Employee.CalcFields(Basic, "Total Allowances", "Total Deductions", "Cumm. PAYE", "Taxable Allowance");
                        OtherAllowances := "Total Allowances" - Basic;
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
                group(GroupName)
                {
                    field(DateFilter; DateFilter)
                    {
                        Caption = 'Payroll period';

                        //TableRelation = "Payroll Period";
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
        GrossPay: Decimal;
        OtherAllowances: Decimal;
        DateFilter: Date;
        ObjDed: Record Deductions;
        Month: Text;
        Year: Integer;
}

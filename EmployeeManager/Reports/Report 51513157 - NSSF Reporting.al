report 51513157 "NSSF Reporting"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/NSSF Reporting.rdl';
    Caption = 'NSSF Reporting';

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
            dataitem(Deductions; Deductions)
            {
                DataItemTableView = sorting (Code) order(ascending) where ("NSSF Deduction" = const (true));

                dataitem("Assignment Matrix"; "Assignment Matrix")
                {
                    DataItemLink = Code = field (Code);
                    DataItemTableView = sorting ("Employee No") order(ascending) where (Type = CONST (Deduction));
                    column(Employee_No; "Employee No")
                    {

                    }
                    column(Code; Code)
                    {

                    }
                    column(Amount; Amount)
                    {

                    }
                    column(EmployeeName; EmployeeName)
                    {

                    }
                    column(NSSFNumber; NSSFNumber)
                    {

                    }
                    column(TotalAmount; TotalAmount)
                    {

                    }
                    column(GrossSalary; GrossSalary)
                    {

                    }
                    column(Month; Month)
                    {

                    }
                    column(Year; Year)
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
                        SetRange("Payroll Period", DateFilter);
                        EmployeeName := '';
                        NSSFNumber := '';
                        TotalAmount := 0;
                        GrossSalary := 0;
                        if ObjEmp.Get("Employee No") then begin
                            ObjEmp.SetRange("Date Filter", DateFilter);
                            ObjEmp.CalcFields("Total Allowances");
                            EmployeeName := ObjEmp."First Name" + ' ' + ObjEmp."Middle Name" + ' ' + ObjEmp."Last Name";
                            NSSFNumber := ObjEmp."NSSF No.";
                            TotalAmount := Abs(Amount) + Abs("Employer Amount");
                            Message('Amount %1, Employer Amount %2, total amount %3', Amount, "Employer Amount", TotalAmount);
                            GrossSalary := ObjEmp."Total Allowances";
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
                "Company Information".CalcFields(Picture);
                if (DateFilter = 0D) then
                    Error('Please specify the date for this report');
                Month := Format(DateFilter, 0, '<Month Text>');
                Year := Date2DMY(DateFilter, 3);
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
            area(Content)
            {
                group(GroupName)
                {
                    field(DateFilter; DateFilter)
                    {
                        Caption = 'Payroll Period';
                        TableRelation = "Payroll Period";
                    }
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
        DateFilter: Date;
        ObjEmp: Record Employee;
        TotalAmount: Decimal;
        EmployeeName: Text;
        NSSFNumber: Code[20];
        GrossSalary: Decimal;
        Month: Text;
        Year: Integer;
}
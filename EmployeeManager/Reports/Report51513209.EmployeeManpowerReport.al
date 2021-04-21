report 51513209 "Employee Manpower Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Employee Manpower Report.rdl';
    Caption = 'Employee Manpower Report';
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
                column(JobTitle; "Job Title")
                {
                }
                column(BirthDate; "Birth Date")
                {
                }
                column(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                }
                column(ContractStartDate; "Contract Start Date")
                {
                }
                column(ContractEndDate; "Contract End Date")
                {
                }
                column(ContractType; "Contract Type")
                {
                }
                column(DateOfJoin; "Date Of Join")
                {
                }
                column(EmploymentStatus; "Employment Status")
                {
                }
                column(Status; Status)
                {
                }
                column(Workstation; Workstation)
                {
                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnAftergetRecord()
                var
                    myInt: Integer;
                begin
                    ObjDimensionValue.Reset();
                    ObjDimensionValue.SetRange(Code, "Global Dimension 1 Code");
                    ObjDimensionValue.SetRange("Global Dimension No.", 1);
                    if ObjDimensionValue.Find('-') then
                        Workstation := ObjDimensionValue.Name
                    else
                        Workstation := '';

                end;

                trigger OnPostDataItem()
                var
                    myInt: Integer;
                begin

                end;
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                "Company Information".CalcFields(Picture)
            end;

            trigger OnAftergetRecord()
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
        Workstation: Text;
        ObjDimensionValue: Record "Dimension Value";
}

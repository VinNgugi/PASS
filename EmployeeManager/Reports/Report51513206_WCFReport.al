report 51513206 "WCF Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/WCF Report.rdl';
    caption = 'WCF Report';

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
                RequestFilterFields = "No.", "Employee Posting Group", "Date Filter";
                column(No_; "No.")
                {

                }
                column(FullName; FullName)
                {

                }
                column(Date_Of_Birth; "Date Of Birth")
                {

                }
                column(Gender; Gender)
                {

                }
                column(Job_Title; "Job Title")
                {

                }
                column(Contract_Type; "Contract Type")
                {

                }
                column(WCF_Number; "WCF Number")
                {

                }
                column(Date_Filter; "Date Filter")
                {

                }
                column(BasicPay; BasicPay)
                {

                }
                column(OtherAllowances; OtherAllowances)
                {

                }
                column(WCFAmount; WCFAmount)
                {

                }
                column(PeriodText; PeriodText)
                {

                }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    PeriodText := Employee.GETFILTER("Date Filter");
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    BasicPay := 0;
                    OtherAllowances := 0;
                    WCFAmount := 0;

                    EarnRec.Reset();
                    EarnRec.SetRange("Basic Salary Code", true);
                    if EarnRec.Find('-') then begin
                        AssignmentMatrix.Reset();
                        AssignmentMatrix.SetRange(Code, EarnRec.Code);
                        AssignmentMatrix.SetRange("Employee No", Employee."No.");
                        AssignmentMatrix.SetRange("Pay Period Filter", "Date Filter");
                        AssignmentMatrix.SetRange(Type, AssignmentMatrix.Type::Payment);
                        if AssignmentMatrix.FindSet() then
                            repeat
                                BasicPay := BasicPay + AssignmentMatrix.Amount;
                            until AssignmentMatrix.Next() = 0;
                    end;

                    EarnRec.Reset();
                    EarnRec.SetRange("Gross Pay Entry", true);
                    //EarnRec.SetRange("Non-Cash Benefit", false);
                    if EarnRec.FindSet() then
                        repeat
                            AssignmentMatrix.Reset();
                            AssignmentMatrix.SetRange(Code, EarnRec.Code);
                            AssignmentMatrix.SetRange("Employee No", Employee."No.");
                            AssignmentMatrix.SetRange("Pay Period Filter", "Date Filter");
                            AssignmentMatrix.SetRange(Type, AssignmentMatrix.Type::Payment);
                            if AssignmentMatrix.FindSet() then
                                repeat
                                    OtherAllowances := OtherAllowances + AssignmentMatrix.Amount;
                                until AssignmentMatrix.Next() = 0;
                        until EarnRec.Next() = 0;

                    DedRec.Reset();
                    DedRec.SetRange("WCF Deduction", true);
                    if DedRec.FindSet() then
                        repeat
                            AssignmentMatrix.Reset();
                            AssignmentMatrix.SetRange(Code, DedRec.Code);
                            AssignmentMatrix.SetRange("Employee No", Employee."No.");
                            AssignmentMatrix.SetRange("Pay Period Filter", "Date Filter");
                            AssignmentMatrix.SetRange(Type, AssignmentMatrix.Type::Deduction);
                            if AssignmentMatrix.FindSet() then
                                repeat
                                    WCFAmount := WCFAmount + AssignmentMatrix."Employer Amount";
                                until AssignmentMatrix.Next() = 0;
                        until DedRec.Next() = 0;

                    if PrinttoExcel then begin
                        RowNo := RowNo + 1;
                        EnterCell(RowNo, 1, Employee."WCF Number", '', false);
                        EnterCell(RowNo, 2, Employee."First Name", '', false);
                        EnterCell(RowNo, 3, Employee."Middle Name", '', false);
                        EnterCell(RowNo, 4, Employee."Last Name", '', false);
                        EnterCell(RowNo, 5, Format(Employee.Gender), '', false);
                        EnterCell(RowNo, 6, Format(Employee."Date Of Birth"), '', false);
                        EnterCell(RowNo, 7, Format(BasicPay), '0.00', false);
                        EnterCell(RowNo, 8, Format(OtherAllowances), '0.00', false);
                        EnterCell(RowNo, 9, 'STAFF', '', false);
                        EnterCell(RowNo, 10, 'TEMPORARY', '', false);
                        EnterCell(RowNo, 11, Employee."ID Number", '', false);

                    end;

                end;


                trigger OnPostDataItem()
                var
                    myInt: Integer;
                begin
                    if PrinttoExcel then begin
                        TempExcelBuffer.CreateBookAndOpenExcel('', COMPANYNAME, Text0030, "Company Information".Name, USERID);
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
                group("Print to Excel")
                {
                    field(PrinttoExcel; PrinttoExcel)
                    {
                        Caption = 'Pring to Excel';
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
    trigger OnPreReport();
    begin
        if PrinttoExcel then begin
            RowNo := 1;
            MakeExcelHeader();
            datestring := FORMAT(TODAY, 10, '<Day,2>/<Month,2>/<Year4>');
            EmployeeCount := 0;
        end;

    end;

    procedure MakeExcelHeader();
    var
        BlankFiller: Text[250];
    begin

        EnterCell(1, 1, 'WCF_NUMBER', '', true);
        EnterCell(1, 2, 'FIRSTNAME', '', true);
        EnterCell(1, 3, 'MIDDLENAME', '', true);
        EnterCell(1, 4, 'LASTNAME', '', true);
        EnterCell(1, 5, 'GENDER', '', true);
        EnterCell(1, 6, 'DOB', '', true);
        EnterCell(1, 7, 'BASICPAY', '', true);
        EnterCell(1, 8, 'GROSSPAY', '', true);
        EnterCell(1, 9, 'JOBTITLE', '', true);
        EnterCell(1, 10, 'EMPLOYMENT_CATEGORY', '', true);
        EnterCell(1, 11, 'NATIONAL_ID', '', true);


    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; NumberFormat: Text[30]; Bold: Boolean);
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        if NumberFormat <> '' then begin
            TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Number;
            TempExcelBuffer.NumberFormat := NumberFormat;
        end else
            TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Text;
        TempExcelBuffer."Cell Value as Text" := CellValue;

        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.INSERT;
    end;

    var
        BasicPay: Decimal;
        OtherAllowances: Decimal;
        WCFAmount: Decimal;
        EarnRec: Record Earnings;
        DedRec: Record Deductions;
        AssignmentMatrix: Record "Assignment Matrix";
        PeriodText: Text;
        PrinttoExcel: Boolean;
        RowNo: Integer;
        datestring: Text;
        EmployeeCount: Integer;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Text0030: TextConst ENU = 'GIFI', ESM = 'GIFI', FRC = 'IGRF', ENC = 'GIFI';

}
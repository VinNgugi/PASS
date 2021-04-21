report 51513418 "Comparison By Banks"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Comparison By Banks';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Comparison By Banks.rdl';

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

            dataitem(Customer; Customer)
            {
                DataItemTableView = where("Customer Posting Group" = filter('BANKS'));
                column(No_; "No.")
                {

                }
                column(CustName; Name)
                {

                }
                column(Quarter; Quarter)
                {

                }
                column(RunDate; RunDate)
                {

                }
                column(PrevPeriod; PrevPeriod)
                {

                }
                column(ContractValue; ContractValue)
                {

                }
                column(ContractValuePrev; ContractValuePrev)
                {

                }
                column(Growth; Growth)
                {

                }
                column(Percentage; Percentage)
                {

                }
                column(PercentagePrev; PercentagePrev)
                {

                }
                column(PercentageGrowth; PercentageGrowth)
                {

                }
                column(Variance; Variance)
                {

                }
                column(PercVariance; PercVariance)
                {

                }
                trigger OnPredataItem()
                var

                begin
                    if RunDate = 0D then begin
                        RunDate := Today;
                    end;

                    Quarter := '';
                    DateFilter := '';
                    PrevYearDateFilter := '';
                    PrevPeriod := CalcDate('-1Y', RunDate);

                    DateFilter := GuarMgmt.FnGetDateFilters(RunDate);
                    PrevYearDateFilter := GuarMgmt.FnGetDateFilters(PrevPeriod);
                    Quarter := GuarMgmt.FnGetPeriodQuarter(RunDate);


                    //*************Get Current Total
                    TotalContractValue := 0;
                    ObjGuarCont.Reset();
                    ObjGuarCont.SetFilter("Application Date", DateFilter);
                    if ObjGuarCont.FindSet() then
                        repeat
                            TotalContractValue := TotalContractValue + ObjGuarCont."Approved Loan Amount";
                        until ObjGuarCont.Next() = 0;

                    //*************Get Last Year Same Period Value
                    TotalContractValuePrev := 0;
                    ObjGuarCont.Reset();
                    ObjGuarCont.SetFilter("Application Date", PrevYearDateFilter);
                    if ObjGuarCont.FindSet() then
                        repeat
                            TotalContractValuePrev := TotalContractValuePrev + ObjGuarCont."Approved Loan Amount";
                        until ObjGuarCont.Next() = 0;

                end;

                trigger OnAfterGetRecord()
                var

                begin
                    //*************Get Current Value
                    ContractValue := 0;
                    Percentage := 0;
                    ObjGuarCont.Reset();
                    ObjGuarCont.SetRange("Receivables Acc. No.", "No.");
                    ObjGuarCont.SetFilter("Application Date", DateFilter);
                    if ObjGuarCont.FindSet() then
                        repeat
                            ContractValue := ContractValue + ObjGuarCont."Approved Loan Amount";
                        until ObjGuarCont.Next() = 0;
                    if TotalContractValue > 0 then
                        Percentage := ((ContractValue / TotalContractValue) * 100);


                    //*************Get Last Year Same Period Value
                    ContractValuePrev := 0;
                    PercentagePrev := 0;
                    ObjGuarCont.Reset();
                    ObjGuarCont.SetRange("Receivables Acc. No.", "No.");
                    ObjGuarCont.SetFilter("Application Date", PrevYearDateFilter);
                    if ObjGuarCont.FindSet() then
                        repeat
                            ContractValuePrev := ContractValuePrev + ObjGuarCont."Approved Loan Amount";
                        until ObjGuarCont.Next() = 0;

                    if TotalContractValuePrev > 0 then
                        PercentagePrev := ((ContractValuePrev / TotalContractValuePrev) * 100);



                    Growth := 0;
                    PercentageGrowth := 0;

                    Growth := ContractValue - ContractValuePrev;

                    if ContractValue > 0 then
                        PercentageGrowth := ((Growth / ContractValue) * 100);


                end;

            }

            trigger OnPredataItem()
            var

            begin
                "Company Information".CalcFields(Picture)
            end;

            trigger OnAfterGetRecord()
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
                group("Run As At Date")
                {
                    field(RunDate; RunDate)
                    {

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
        ObjGuarCont: Record "Guarantee Contracts";
        ContractValue: Decimal;
        TotalContractValue: Decimal;
        Percentage: Decimal;
        ContractValuePrev: Decimal;
        TotalContractValuePrev: Decimal;
        PercentagePrev: Decimal;
        Growth: Decimal;
        PercentageGrowth: Decimal;
        DateFilter: Text;
        PrevYearDateFilter: Text;
        RunDate: Date;
        Month: Integer;
        StartDate: Date;
        EndDate: Date;
        Quarter: Text;
        PrevPeriod: Date;
        Variance: Decimal;
        PercVariance: Decimal;
        GuarMgmt: Codeunit "Guarantee Management";

}
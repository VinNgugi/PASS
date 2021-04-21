codeunit 51513505 "Automated Investment Processes"
{
    trigger OnRun()
    begin
        Investment.Reset();
        repeat
        //InvestmemtMgmt.FnPopulateInvestmentInterest(Investment, Today);
        until Investment.Next() = 0;

    end;

    var
        Investment: Record "Investment Header";
        InvestmemtMgmt: Codeunit "Investment Management";
}
report 51513115 "Create Payroll Period"
{
    // version PAYROLL

    Caption = 'Create Fiscal Year';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FiscalYearStartDate; FiscalYearStartDate)
                    {
                        Caption = 'Starting Date';
                    }
                    field(NoOfPeriods; NoOfPeriods)
                    {
                        Caption = 'No. of Periods';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                    }
                    field(PeriodType; PeriodType)
                    {
                        Caption = 'Period Type';
                    }
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
        AccountingPeriod."Starting Date" := FiscalYearStartDate;
        AccountingPeriod.TESTFIELD("Starting Date");

        if AccountingPeriod.FIND('-') then begin
            FirstPeriodStartDate := AccountingPeriod."Starting Date";
            FirstPeriodLocked := AccountingPeriod."Date Locked";
            if (FiscalYearStartDate < FirstPeriodStartDate) and FirstPeriodLocked then
                if not
                   CONFIRM(
                     Text000 +
                     Text001)
                then
                    exit;
            if AccountingPeriod.FIND('+') then
                LastPeriodStartDate := AccountingPeriod."Starting Date";
        end else
            if not
               CONFIRM(
                 Text002 +
                 Text003)
            then
                exit;
        HRSetup.Get();
        HRSetup.TestField("L.Allowance Days Setup");
        for i := 1 to NoOfPeriods + 1 do begin
            if (FiscalYearStartDate <= FirstPeriodStartDate) and (i = NoOfPeriods + 1) then
                exit;
            /*
            IF (FirstPeriodStartDate <> 0D) THEN
              IF (FiscalYearStartDate >= FirstPeriodStartDate) AND (FiscalYearStartDate < LastPeriodStartDate) THEN
                ERROR(Text004);
            */
            AccountingPeriod.INIT;
            AccountingPeriod."Starting Date" := FiscalYearStartDate;
            AccountingPeriod.Type := PeriodType;
            AccountingPeriod.VALIDATE("Starting Date");
            AccountingPeriod."L.Allowance Cutoff Date" := CalcDate(HRSetup."L.Allowance Days Setup", AccountingPeriod."Starting Date");
            if (i = 1) or (i = NoOfPeriods + 1) then
                AccountingPeriod."New Fiscal Year" := true;
            if (FirstPeriodStartDate = 0D) and (i = 1) then
                AccountingPeriod."Date Locked" := true;
            if (AccountingPeriod."Starting Date" < FirstPeriodStartDate) and FirstPeriodLocked then begin
                AccountingPeriod.Closed := true;
                AccountingPeriod."Date Locked" := true;
            end;
            if not AccountingPeriod.FIND('=') then
                AccountingPeriod.INSERT;
            FiscalYearStartDate := CALCDATE(PeriodLength, FiscalYearStartDate);
        end;

    end;

    var
        Text000: Label 'The new fiscal year begins before an existing fiscal year, so the new year will be closed automatically.\\';
        Text001: Label 'Do you want to create and close the fiscal year?';
        Text002: Label 'Once you create the new fiscal year you cannot change its starting date.\\';
        Text003: Label 'Do you want to create the fiscal year?';
        Text004: Label 'It is only possible to create new fiscal years before or after the existing ones.';
        AccountingPeriod: Record "Payroll Period";
        NoOfPeriods: Integer;
        PeriodLength: DateFormula;
        FiscalYearStartDate: Date;
        FirstPeriodStartDate: Date;
        LastPeriodStartDate: Date;
        FirstPeriodLocked: Boolean;
        i: Integer;
        PeriodType: Option " ",Daily,Weekly,"Bi-Weekly",Monthly;
        HRSetup: Record "Human Resources Setup";
}


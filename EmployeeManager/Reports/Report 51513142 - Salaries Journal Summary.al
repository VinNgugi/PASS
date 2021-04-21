report 51513142 "Salaries Journal Summary"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Salaries Journal Summary.rdl';
    Caption = 'Trial Balance';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TABLECAPTION)
            {
            }
            column(G_L_Account_No_; "Account No.")
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FIELDCAPTION("Account No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                column(G_L_Account___No__; "Gen. Journal Line"."Account No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; "Gen. Journal Line".Description)
                {
                }
                column(G_L_Account___Net_Change_; "Gen. Journal Line".Amount)
                {
                }
                column(G_L_Account___Net_Change__Control22; -"Gen. Journal Line".Amount)
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; FORMAT("Gen. Journal Line"."Account Type", 0, 2))
                {
                }
            }
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
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
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

    trigger OnPostReport();
    begin
        //IF PrintToExcel THEN
        //  CreateExcelbook;
    end;

    trigger OnPreReport();
    begin
        //GLFilter := "G/L Account".GETFILTERS;
        //PeriodText := "G/L Account".GETFILTER("Date Filter");
        //IF PrintToExcel THEN
        //MakeExcelInfo;


        // Employee.SETFILTER("Pay Period Filter",'%1',MonthStartDate);
        "Gen. Journal Line".SETFILTER("Posting Date", '%1', MonthStartDate);
    end;

    var
        Text000: Label 'Period: %1';
        ExcelBuf: Record "Excel Buffer" temporary;
        GLFilter: Text[250];
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        Text001: Label 'Trial Balance';
        Text002: Label 'Data';
        Text003: Label 'Debit';
        Text004: Label 'Credit';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        Text011: Label 'Period Filter';
        Trial_BalanceCaptionLbl: Label 'Payroll Journal Summary';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Net_ChangeCaptionLbl: Label 'Amount';
        BalanceCaptionLbl: Label 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: Label 'Credit';
        MonthStartDate: Date;
}


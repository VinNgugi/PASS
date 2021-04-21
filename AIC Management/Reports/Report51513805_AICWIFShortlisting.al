report 51513805 "WIF Shortlisting"
{
    RDLCLayout = './Layouts/AICWIFShortlisting.rdl';
    DefaultLayout = RDLC;
    Caption = 'WIF Shortlisting';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Non-Wall Applications"; "Non-Wall Applications")
        {

            DataItemTableView = sorting ("Application ID") where (Submitted = filter (true), Qualified = filter (true), Shortlisted = filter (false));
            RequestFilterFields = "Application ID", "Application Date";


            trigger OnPreDataItem()

            begin
                Window.OPEN(Text000);
                i := 0;
                AppScore.DELETEALL;
            end;

            trigger OnAfterGetRecord()

            begin

                Window.UPDATE(1, "Application ID");
                CALCFIELDS("WIF Total Score");
                IF ("WIF Total Score" = 0) THEN
                    CurrReport.SKIP;

                AppScore.INIT;
                AppScore."Applicant No." := "Application ID";
                AppScore.Score := "WIF Total Score";
                AppScore.INSERT(true);

                IF (NoOfRecordsToPrint = 0) OR (i < NoOfRecordsToPrint) THEN
                    i := i + 1
                ELSE BEGIN
                    AppScore.FIND('+');
                    AppScore.DELETE;
                END;

            end;

        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));

            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)

            {

            }
            column(RankedAccordingShowType; STRSUBSTNO(Text002, SELECTSTR(ShowType + 1, Text004)))
            {

            }
            column(CustFilter; CustFilter)
            {

            }
            column(JobApplicants_No; "Non-Wall Applications"."Application ID")
            {
                IncludeCaption = true;
            }
            column(Name_Customer; Name)
            {
                //IncludeCaption = true;
            }
            column(EnterpreneurshipTestScore; "Non-Wall Applications"."WIF Total Score")
            {
                IncludeCaption = true;
            }
            column(CustomerTop10ListCaption; CustomerTop10ListCaptionLbl)
            {

            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {

            }

            trigger OnPreDataItem()

            begin
                Window.Close();
            end;

            trigger OnAfterGetRecord()

            begin

                IF Number = 1 THEN BEGIN
                    IF NOT AppScore.FIND('-') THEN
                        CurrReport.BREAK;
                END ELSE
                    IF AppScore.NEXT = 0 THEN
                        CurrReport.BREAK;
                AppScore.Score := -AppScore.Score;
                "Non-Wall Applications".GET(AppScore."Applicant No.");
                "Non-Wall Applications".CALCFIELDS("WIF Total Score");
                Name := "Non-Wall Applications"."Business Name";
                IF MaxAmount = 0 THEN
                    MaxAmount := AppScore.Score;
                AppScore.Score := -AppScore.Score;


                "Non-Wall Applications".Shortlisted := TRUE;
                "Non-Wall Applications".MODIFY;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(Quantity; NoOfRecordsToPrint)
                    {
                        ApplicationArea = "#Basic,#Suite";
                        Caption = 'Quantity';
                        ToolTip = 'Specifies the number of applicants that will be shortlisted.';

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
        Text000: TextConst ENU = 'Sorting Applicants    #1##########';
        Text001: TextConst ENU = 'Period: %1';
        Text002: TextConst ENU = 'Ranked according to %1';
        Text004: TextConst ENU = 'Sales (LCY),Balance (LCY)';
        CustomerTop10ListCaptionLbl: TextConst ENU = 'CustomerTop10ListCaptionLbl';
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page';
        TotalCaptionLbl: TextConst ENU = 'Total';
        TotalSalesCaptionLbl: TextConst ENU = 'Total Sales';
        PercentofTotalSalesCaptionLbl: TextConst ENU = '% of Total Sales';
        Name: Text;
        AppScore: Record "Applicant Score";
        Window: Dialog;
        CustFilter: Text;
        CustDateFilter: Text;
        ShowType: Option "Sales (LCY)","Balance (LCY)";
        NoOfRecordsToPrint: Integer;
        MaxAmount: Decimal;
        i: Integer;
        WIF: Record "WIF Test";
        WIFEntry: Record "WIF Test Entry";


}
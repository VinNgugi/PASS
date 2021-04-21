report 51513536 "Applicants - Top 10 List(Tech)"
{
    // version NAVW111.00

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ApplicantsTop10List(Tech).rdl';
    Caption = 'Applicants - Top 10 List';

    dataset
    {
        dataitem("Job Applicants"; "Job Applicants")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Job Applied for", "Job ID";

            trigger OnAfterGetRecord();
            begin
                Window.UPDATE(1, "No.");
                CALCFIELDS("Tech Interview Total Score");
                if ("Tech Interview Total Score" = 0) then
                    CurrReport.SKIP;
                AppScore.INIT;
                AppScore."Applicant No." := "No.";
                AppScore.Score := "Tech Interview Total Score";
                if not AppScore.INSERT(true) then
                    Message('HALLO');

                if (NoOfRecordsToPrint = 0) or (i < NoOfRecordsToPrint) then
                    i := i + 1
                else begin
                    AppScore.FIND('+');
                    AppScore.DELETE;
                end;
            end;

            trigger OnPreDataItem();
            begin
                Window.OPEN(Text000);
                i := 0;
                AppScore.DELETEALL;
                //CurrReport.CREATETOTALS("Sales (LCY)","Balance (LCY)");
            end;
        }
        dataitem("Integer"; "Integer")
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
            column(JobApplicants_No; "Job Applicants"."No.")
            {
                IncludeCaption = true;
            }
            column(Name_Customer; Name)
            {
                //IncludeCaption = true;
            }
            column(ShortlistingTotalScore; "Job Applicants"."Tech Interview Total Score")
            {
                IncludeCaption = true;
            }
            column(CustomerTop10ListCaption; CustomerTop10ListCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin

                if Number = 1 then begin
                    if not AppScore.FIND('-') then
                        CurrReport.BREAK;
                end else
                    if AppScore.NEXT = 0 then
                        CurrReport.BREAK;
                AppScore.Score := -AppScore.Score;
                "Job Applicants".GET(AppScore."Applicant No.");
                "Job Applicants".CALCFIELDS("Tech Interview Total Score");
                Name := "Job Applicants"."First Name" + ' ' + "Job Applicants"."Last Name";
                if MaxAmount = 0 then
                    MaxAmount := AppScore.Score;
                AppScore.Score := -AppScore.Score;

                if StageCode.GET("Job Applicants"."Job ID") then begin
                    StageShortlist.INIT;
                    StageShortlist."Need Code" := "Job Applicants"."Job ID";
                    StageShortlist."Stage Code" := StageCode."Stage Code";
                    StageShortlist.Applicant := "Job Applicants"."No.";
                    StageShortlist."Stage Score" := "Job Applicants"."Tech Interview Total Score";
                    StageShortlist.Qualified := true;
                    StageShortlist."First Name" := "Job Applicants"."First Name";
                    StageShortlist."Middle Name" := "Job Applicants"."Middle Name";
                    StageShortlist."Last Name" := "Job Applicants"."Last Name";
                    StageShortlist."ID No" := "Job Applicants"."ID Number";
                    StageShortlist.Gender := "Job Applicants".Gender;
                    StageShortlist."Marital Status" := "Job Applicants"."Marital Status";
                    StageShortlist.INSERT;

                    StageCode."Passed Technical Test" := true;
                    StageCode.Modify();
                end;



                //StageShortlist.SETRANGE(Qualified,TRUE);
                //IF StageShortlist.FINDFIRST THEN BEGIN
                //REPEAT
                //"Job Applicants".GET(StageShortlist.Applicant);
                "Job Applicants"."Passed Tech Interview" := true;
                "Job Applicants".MODIFY;
                //UNTIL "Job Applicants".NEXT=0;
                //END;
                /*
                RecCount:= 0;
                MyCount:=0;
                
                StageShortlist.RESET;
                StageShortlist.SETRANGE(StageShortlist."Need Code","Job Applicants"."Job ID");
                StageShortlist.SETRANGE(StageShortlist."Stage Code",StageCode."Stage Code");
                IF StageShortlist.FIND('-') THEN BEGIN
                RecCount:=StageShortlist.COUNT;
                StageShortlist.SETCURRENTKEY(StageShortlist."Stage Score");
                StageShortlist.ASCENDING;
                REPEAT
                MyCount:=MyCount + 1;
                StageShortlist.Position:=RecCount - MyCount;
                StageShortlist.MODIFY;
                UNTIL StageShortlist.NEXT = 0;
                END;
                 */

            end;

            trigger OnPreDataItem();
            begin
                Window.CLOSE;
                //CurrReport.CREATETOTALS(Customer."Sales (LCY)",Customer."Balance (LCY)");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfRecordsToPrint; NoOfRecordsToPrint)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Quantity';
                        ToolTip = 'Specifies the number of customers that will be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            ChartTypeVisible := true;
        end;

        trigger OnOpenPage();
        begin
            if NoOfRecordsToPrint = 0 then
                NoOfRecordsToPrint := 10;
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    var
        CaptionManagement: Codeunit CaptionManagement;
    begin
        //CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);
        //CustDateFilter := Customer.GETFILTER("Date Filter");
    end;

    var
        Text000: Label 'Sorting Applicants    #1##########';
        Text001: Label 'Period: %1';
        Text002: Label 'Ranked according to %1';
        AppScore: Record "Applicant Score" temporary;
        Window: Dialog;
        CustFilter: Text;
        CustDateFilter: Text;
        ShowType: Option "Sales (LCY)","Balance (LCY)";
        NoOfRecordsToPrint: Integer;
        MaxAmount: Decimal;
        i: Integer;
        TotalSales: Decimal;
        Text004: Label 'Sales (LCY),Balance (LCY)';
        TotalBalance: Decimal;
        ChartType: Option "Bar chart","Pie chart";
        ChartTypeNo: Integer;
        ShowTypeNo: Integer;
        [InDataSet]
        ChartTypeVisible: Boolean;
        CustomerTop10ListCaptionLbl: Label 'Applicants - Top 10 List';
        CurrReportPageNoCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        TotalSalesCaptionLbl: Label 'Total Sales';
        PercentofTotalSalesCaptionLbl: Label '% of Total Sales';
        StageShortlist: Record "Stage Shortlist";
        StageCode: Record "Recruitment Needs";
        RecCount: Integer;
        MyCount: Integer;
        Name: Text;

    procedure InitializeRequest(SetChartType: Option; SetShowType: Option; NoOfRecords: Integer);
    begin
        ChartType := SetChartType;
        ShowType := SetShowType;
        NoOfRecordsToPrint := NoOfRecords;
    end;
}


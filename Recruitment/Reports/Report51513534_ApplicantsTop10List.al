report 51513534 "Applicants - Top 10 List"
{
    RDLCLayout = './Layouts/ApplicantsTop10List.rdl';
    DefaultLayout = RDLC;
    Caption = 'Applicants - Top 10 List';


    dataset
    {
        dataitem("Job Applicants"; "Job Applicants")
        {
            DataItemTableView = sorting ("No.");
            RequestFilterFields = "No.", "Job Applied for", "Job ID";


            trigger OnPreDataItem()

            begin
                Window.OPEN(Text000);
                i := 0;
                AppScore.DELETEALL;
            end;

            trigger OnAfterGetRecord()

            begin
                Window.UPDATE(1, "No.");
                CALCFIELDS("Shortlisting Total Score");
                IF ("Shortlisting Total Score" = 0) THEN
                    CurrReport.SKIP;
                AppScore.INIT;
                AppScore."Applicant No." := "No.";
                AppScore.Score := "Shortlisting Total Score";
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
            column(JobApplicants_No; "Job Applicants"."No.")
            {
                IncludeCaption = true;
            }
            column(Name_Customer; Name)
            {
                //IncludeCaption = true;
            }
            column(ShortlistingTotalScore; "Job Applicants"."Shortlisting Total Score")
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
                "Job Applicants".GET(AppScore."Applicant No.");
                "Job Applicants".CALCFIELDS("Shortlisting Total Score");
                Name := "Job Applicants"."First Name" + ' ' + "Job Applicants"."Last Name";
                IF MaxAmount = 0 THEN
                    MaxAmount := AppScore.Score;
                AppScore.Score := -AppScore.Score;

                IF StageCode.GET("Job Applicants"."Job ID") THEN BEGIN
                    StageShortlist.INIT;
                    StageShortlist."Need Code" := "Job Applicants"."Job ID";
                    StageShortlist."Stage Code" := StageCode."Stage Code";
                    StageShortlist.Applicant := "Job Applicants"."No.";
                    StageShortlist."Stage Score" := "Job Applicants"."Shortlisting Total Score";
                    StageShortlist.Qualified := TRUE;
                    StageShortlist."First Name" := "Job Applicants"."First Name";
                    StageShortlist."Middle Name" := "Job Applicants"."Middle Name";
                    StageShortlist."Last Name" := "Job Applicants"."Last Name";
                    StageShortlist."ID No" := "Job Applicants"."ID Number";
                    StageShortlist.Gender := "Job Applicants".Gender;
                    StageShortlist."Marital Status" := "Job Applicants"."Marital Status";
                    StageShortlist.INSERT;
                    StageCode."Short Listing Done?" := true;
                    StageCode.Modify();
                END;
                ;
                "Job Applicants".Qualified := TRUE;
                "Job Applicants".MODIFY;
                /*
                StageShortlist.SETRANGE(Qualified,TRUE);
                IF StageShortlist.FINDFIRST THEN BEGIN
                REPEAT
                "Job Applicants".GET(StageShortlist.Applicant);
                "Job Applicants".Qualified:=TRUE;
                "Job Applicants".MODIFY;
                UNTIL "Job Applicants".NEXT=0;
                END;

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
        TotalSales: Decimal;
        TotalBalance: Decimal;
        StageShortlist: Record "Stage Shortlist";
        StageCode: Record "Recruitment Needs";



}
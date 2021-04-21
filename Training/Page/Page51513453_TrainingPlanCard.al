page 51513453 "Plan Card"
{
    PageType = Card;
    SourceTable = "Training Plan";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;

                }
                field("Document Date"; "Document Date")
                {

                }
                field("Training Description"; "Training Description")
                {

                }
                field("Training Objective"; "Training Objective")
                {

                }
                field("Training Start Date"; "Training Start Date")
                {

                }
                field("Training Period"; "Training Period")
                {

                }
                field("Training End Date"; "Training End Date")
                {

                }
                field("Training Type"; "Training Type")
                {

                }
                field("Training Classification"; "Training Classification")
                {

                }
                field("Destination Type"; "Destination Type")
                {

                }
                field("Currency Code"; "Currency Code")
                {
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Document Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);

                        CLEAR(ChangeExchangeRate);
                    end;


                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if "Currency Code" <> '' then
                            LCYVisible := true
                        else
                            LCYVisible := false;
                    end;


                }
                field("Training Provider"; "Training Provider")
                {

                }
                field("Training Provider Name"; "Training Provider Name")
                {

                }
                field("Training Destination"; "Training Destination")
                {

                }
                field(Sponsor; Sponsor)
                {

                }
                field("Budget Code"; "Budget Code")
                {

                }
                field("Budget Name"; "Budget Name")
                {

                }
                field("Created By"; "Created By")
                {

                }
                field("Responsibility Center"; "Responsibility Center")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Total Perdiem"; "Total Perdiem")
                {

                }

                field("Total Accomodation"; "Total Accomodation")
                {

                }

                field("Total Air Ticket Fee"; "Total Air Ticket Fee")
                {

                }

                field("Total Travel-Expence"; "Total Travel-Expence")
                {

                }

                field("Gross Amount"; "Gross Amount")
                {

                }

                group("Amounts LCY")
                {
                    Visible = LCYVisible;
                    field("Total Perdiem(LCY)"; "Total Perdiem(LCY)")
                    {

                    }
                    field("Total Accomodation(LCY)"; "Total Accomodation(LCY)")
                    {

                    }
                    field("Total Air-Ticket(LCY)"; "Total Air-Ticket(LCY)")
                    {

                    }
                    field("Total Travel-Expence(LCY)"; "Total Travel-Expence(LCY)")
                    {

                    }
                    field("Gross Amount(LCY)"; "Gross Amount(LCY)")
                    {

                    }
                }
            }
            part("Employee List"; "Training Employees")
            {
                SubPageLink = "Training Header No." = field ("Request No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Submit Training")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    TrainingLines.Reset();
                    TrainingLines.SetRange("Training Header No.", "Request No.");
                    if TrainingLines.Find('-') then begin
                        TrainingMgmt.FnSendTrainingNotification(TrainingLines);
                    end;

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if "Currency Code" <> '' then
            LCYVisible := true
        else
            LCYVisible := false;
    end;

    var
        TrainingMgmt: Codeunit "Training Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        TrainingLines: Record "Training Participants Lines";
        LCYVisible: Boolean;
}
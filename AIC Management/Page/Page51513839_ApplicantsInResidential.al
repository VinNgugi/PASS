page 51513839 "Applicants in Residential"
{
    PageType = List;
    SourceTable = "Incubation Applicants";
    SourceTableView = sorting ("No.") order(ascending);
    Editable = false;
    InsertAllowed = false;
    Caption = 'Applicants in Residential Selection';
    CardPageId = "Applicant Card(AIC)";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field(Name; Name)
                {

                }

                field("Incubation Code"; "Incubation Code")
                {

                }
                field("Incubation Name"; "Incubation Name")
                {

                }
                field(Submitted; Submitted)
                {

                }
                field(Admitted; Admitted)
                {

                }
                field("E-Mail"; "E-Mail")
                {

                }
                field("Application Date"; "Application Date")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {

                }
            }
        }


    }

    actions
    {
        area(Processing)
        {
            action("Admit")
            {
                Image = Administration;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RescourceRec: Record Resource;
                    NoSeriesManagement: Codeunit NoSeriesManagement;
                    RescourceSetup: Record "Resources Setup";
                    AICSetup: Record "AIC Setup";
                begin
                    AICSetup.Get();
                    RescourceSetup.Get();

                    Applicants.Reset();
                    CurrPage.SetSelectionFilter(Applicants);
                    if Applicants.FindSet() then begin
                        repeat
                            TestField("Resident Selection", true);
                            with RescourceRec do begin
                                Init();
                                "No." := NoSeriesManagement.GetNextNo(RescourceSetup."Resource Nos.", Today, true);
                                Name := Rec.Name;
                                "VAT Prod. Posting Group" := AICSetup."VAT Prod. Posting Group";
                                "Gen. Prod. Posting Group" := AICSetup."Gen. Prod. Posting Group";
                                "Resource Group No." := AICSetup."Resource Group";
                                "Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                "Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                Address := Rec.Address;
                                "Address 2" := Rec."Address 2";
                                "Post Code" := rec."Post Code";
                                City := Rec.City;
                                "Country/Region Code" := Rec."Country/Region Code";
                                if not Insert() then
                                    Error('Cannot create Rescource record for application %1 (%2)', Rec."No.", Rec.Name)
                                else begin
                                    Message('Rescource No.: %1 successfully created', RescourceRec."No.");
                                    Rec.Admitted := true;
                                    Rec."Admission Date" := Today;
                                    Rec."Admission Time" := Time;
                                    Rec."Admitted by" := UserId;
                                    Rec.Modify();
                                end;
                            end
                        until Applicants.Next() = 0;
                        Message('Successfully admitted');
                    end;
                end;
            }
        }
    }
    var
        Applicants: Record "Incubation Applicants";
}
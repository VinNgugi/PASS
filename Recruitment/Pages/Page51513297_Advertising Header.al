page 51513297 "Advertising Header"
{
    PageType = Card;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE (Status = FILTER (Released));

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; "No.")
                {

                }
                field("Job ID"; "Job ID")
                {

                }
                field(Description; Description)
                {

                }
                field(Position; Position)
                {

                }
                field("Start Date"; "Start Date")
                {

                }
                field("End Date"; "End Date")
                {

                }
                field("Expected Reporting Date"; "Expected Reporting Date")
                {

                }
                field(Posted; Posted)
                {

                }
            }
            /*part(AdvertisingLines; "Advertising Lines")
            {
                Caption = 'Advertising';
                SubPageLink = "Need Code" = FIELD ("No.");
            }*/
        }

    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;
                Image = Post;

                trigger OnAction()
                begin

                    /*                   
                LineNo := 1;
                                    Advertising.RESET;
                                    Advertising.SETRANGE("Need Code","No.");
                                    Advertising.SETRANGE(Advertising.Posted, FALSE);
                                    IF Advertising.FIND('-') THEN BEGIN
                                        REPEAT
                                            PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
                                            PurchaseHeader."No." := '8';
                                            PurchaseHeader."Buy-from Vendor No." := Advertising."Advertising Media";
                                            PurchaseHeader.VALIDATE("Buy-from Vendor No.");
                                            PurchaseHeader.INSERT;

                                            PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice;
                                            PurchaseLine."Line No." := LineNo;
                                            PurchaseLine."Document No." := '8';
                                            PurchaseLine.Type := PurchaseLine.Type::Item;
                                            PurchaseLine."No." := '70061';//Get Gl account for advertisement
                                            PurchaseLine.VALIDATE("No.");
                                            PurchaseLine.Quantity := 1;
                                            PurchaseLine."Unit Cost" := Advertising.Amount;
                                            PurchaseLine.VALIDATE("Unit Cost");
                                            PurchaseLine.INSERT;
                                            LineNo := LineNo + 1;
                                            Advertising.Posted := TRUE;
                                            Advertising.MODIFY;
                                        UNTIL Advertising.NEXT = 0;
                                    END;

                                */
                    IF Posted = FALSE THEN BEGIN
                        Posted := TRUE;
                        MESSAGE('Job Advert has been posted');
                    END ELSE
                        MESSAGE('This advert is already posted');
                end;


            }
        }
    }

    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        //Advertising: Record Advertising;
        LineNo: Integer;

}
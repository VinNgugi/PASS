page 51513324 "Employee Linked Docs"
{
    // version HR

    PageType = Card;
    SourceTable = Employee;
    SourceTableView = WHERE (Status = CONST (Active));
    Caption = 'Employee Linked Docs';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; "No.")
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field(Initials; Initials)
                {
                }
                field("ID Number"; "ID Number")
                {
                }
                field(Gender; Gender)
                {
                }
                field(Position; Position)
                {
                }
                field("Contract Type"; "Contract Type")
                {
                }
                field("Date Of Join"; "Date Of Join")
                {
                }
            }
            field(Control1000000030; '')
            {
                CaptionClass = Text19034836;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(DocLink; "Document Link")
            {
                SubPageLink = "Employee No" = FIELD ("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Attachment")
            {
                Caption = '&Attachment';
                action(Open)
                {
                    Caption = 'Open';
                    ShortCutKey = 'Return';

                    trigger OnAction();
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.GET("No.", CurrPage.DocLink.PAGE.GetDocument) then begin
                            if InteractTemplLanguage.GET(CurrPage.DocLink.PAGE.GetDocument, DocLink."Language Code (Default)") then
                                InteractTemplLanguage.OpenAttachment;
                        end;
                    end;
                }
                action(Create)
                {
                    Caption = 'Create';
                    Ellipsis = true;

                    trigger OnAction();
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.GET("No.", CurrPage.DocLink.PAGE.GetDocument) then begin
                            if not InteractTemplLanguage.GET(CurrPage.DocLink.PAGE.GetDocument, DocLink."Language Code (Default)") then begin
                                InteractTemplLanguage.INIT;
                                InteractTemplLanguage."Interaction Template Code" := CurrPage.DocLink.PAGE.GetDocument;
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := CurrPage.DocLink.PAGE.GetDocument;
                            end;
                            InteractTemplLanguage.CreateAttachment;
                            CurrPage.UPDATE;
                            DocLink.Attachement := DocLink.Attachement::Yes;
                            DocLink.MODIFY;
                        end;
                    end;
                }
                action("Copy &from")
                {
                    Caption = 'Copy &from';
                    Ellipsis = true;

                    trigger OnAction();
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.GET("No.", CurrPage.DocLink.PAGE.GetDocument) then begin
                            if not InteractTemplLanguage.GET(DocLink."Document Description", DocLink."Language Code (Default)") then begin
                                InteractTemplLanguage.INIT;
                                InteractTemplLanguage."Interaction Template Code" := DocLink."Document Description";
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := DocLink."Document Description";
                                InteractTemplLanguage.INSERT;
                                COMMIT;
                            end;
                            InteractTemplLanguage.CopyFromAttachment;
                            CurrPage.UPDATE;
                            DocLink.Attachement := DocLink.Attachement::Yes;
                            DocLink.MODIFY;
                        end;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;

                    trigger OnAction();
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.GET("No.", CurrPage.DocLink.PAGE.GetDocument) then begin
                            if not InteractTemplLanguage.GET(DocLink."Document Description", DocLink."Language Code (Default)") then begin
                                InteractTemplLanguage.INIT;
                                InteractTemplLanguage."Interaction Template Code" := DocLink."Document Description";
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := DocLink."Document Description";
                                InteractTemplLanguage.INSERT;
                            end;
                            InteractTemplLanguage.ImportAttachment;
                            CurrPage.UPDATE;
                            DocLink.Attachement := DocLink.Attachement::Yes;
                            DocLink.MODIFY;
                        end;
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;

                    trigger OnAction();
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.GET("No.", CurrPage.DocLink.PAGE.GetDocument) then begin
                            if InteractTemplLanguage.GET(DocLink."Document Description", DocLink."Language Code (Default)") then
                                InteractTemplLanguage.ExportAttachment;
                        end;
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;

                    trigger OnAction();
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.GET("No.", CurrPage.DocLink.PAGE.GetDocument) then begin
                            if InteractTemplLanguage.GET(DocLink."Document Description", DocLink."Language Code (Default)") then begin
                                InteractTemplLanguage.RemoveAttachment(true);
                                DocLink.Attachement := DocLink.Attachement::No;
                                DocLink.MODIFY;
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        DocLink: Record "Document Link";
        Text19034836: Label 'Employee Linked Documents';
}


page 51513334 "Disciplinary Cases Card"
{
    // version HR
    Caption = 'Disciplinary Cases Card';
    PageType = Card;
    SourceTable = "Disciplinary Cases";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case No"; "Case No")
                {
                    Editable = false;
                }
                field("Case Description"; "Case Description")
                {
                }
                field("Date of the Case"; "Date of the Case")
                {
                }
                field("Offense Type"; "Offense Type")
                {
                }
                field("Offense Name"; "Offense Name")
                {
                    Editable = false;
                }
                field("Employee No"; "Employee No")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field("Previous Disciplinary Case"; "Previous Disciplinary Case")
                {
                    Editable = false;
                }
                field("Levels of Discipline"; "Levels of Discipline")
                {
                    Editable = true;
                }
                field("Case Status"; "Case Status")
                {
                    Editable = false;
                }
                field("HOD Name"; "HOD Name")
                {
                    Editable = false;
                }
                field("HOD Recommendation"; "HOD Recommendation")
                {
                    MultiLine = true;
                }
                field("HR Recommendation"; "HR Recommendation")
                {
                    MultiLine = true;
                }
                field("CEO Recommendation"; "CEO Recommendation")
                {
                    MultiLine = true;
                }
                field("Warning Letter Attachment Path"; "Warning Letter Attachment Path")
                {

                }
                field("Commitee Recommendation"; "Commitee Recommendation")
                {
                    MultiLine = true;
                    Visible = ongoingbl;
                }
                field("Action Taken"; "Action Taken")
                {
                    // Visible = ongoingbl;
                }
                field("Action Taken Description"; "Action Taken Description")
                {

                }
                field(Appealed; Appealed)
                {
                    Visible = false;
                }
                field("Committee Recon After Appeal"; "Committee Recon After Appeal")
                {
                    Caption = 'Board-Finance & HR Committe Recomendation';
                    Visible = appealedbl;
                }
                field("No. of Appeals"; "No. of Appeals")
                {
                    Visible = closedbl;
                }
                field("Court's Decision"; "Court's Decision")
                {
                    Visible = courtbl;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Proceed To Ongoing")
            {
                Image = OutboundEntry;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = openbl;

                trigger OnAction();
                begin
                    if "HOD Recommendation" = '' then begin
                        ERROR('HOD Recommendation is Empty');
                    end;
                    if "HR Recommendation" = '' then begin
                        ERROR('HR Recommendation is Empty');
                    end;

                    "Case Status" := "Case Status"::Ongoing;
                    MESSAGE('Moved to Ongoing Cases Menu...');
                    CurrPage.CLOSE;
                end;
            }
            action("Attach HOD Recommendation")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = openbl;

                trigger OnAction();
                begin
                    filename := FileCU.OpenFileDialog('Select  File', '', '');
                    if filename <> '' then begin
                        HRsetup.RESET;
                        HRsetup.GET;
                        filename2 := FORMAT(CURRENTDATETIME) + '_' + USERID;
                        filename2 := CONVERTSTR(filename2, '/', '_');
                        filename2 := CONVERTSTR(filename2, '\', '_');
                        filename2 := CONVERTSTR(filename2, ':', '_');
                        filename2 := CONVERTSTR(filename2, '.', '_');
                        filename2 := CONVERTSTR(filename2, ',', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        FileCU.CopyClientFile(filename, HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename), true);
                        "HOD File Path" := HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename);
                        MESSAGE('File Attached Successfully');
                    end;
                end;
            }
            action("Attach HR Recommendation")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = openbl;

                trigger OnAction();
                begin
                    filename := FileCU.OpenFileDialog('Select  File', '', '');
                    if filename <> '' then begin
                        HRsetup.RESET;
                        HRsetup.GET;
                        filename2 := FORMAT(CURRENTDATETIME) + '_' + USERID;
                        filename2 := CONVERTSTR(filename2, '/', '_');
                        filename2 := CONVERTSTR(filename2, '\', '_');
                        filename2 := CONVERTSTR(filename2, ':', '_');
                        filename2 := CONVERTSTR(filename2, '.', '_');
                        filename2 := CONVERTSTR(filename2, ',', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        FileCU.CopyClientFile(filename, HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename), true);
                        "HR File Path" := HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename);
                        MESSAGE('File Attached Successfully');
                    end;
                end;
            }
            action("Attach Commitee Minutes")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ongoingbl;

                trigger OnAction();
                begin
                    filename := FileCU.OpenFileDialog('Select  File', '', '');
                    if filename <> '' then begin
                        HRsetup.RESET;
                        HRsetup.GET;
                        filename2 := FORMAT(CURRENTDATETIME) + '_' + USERID;
                        filename2 := CONVERTSTR(filename2, '/', '_');
                        filename2 := CONVERTSTR(filename2, '\', '_');
                        filename2 := CONVERTSTR(filename2, ':', '_');
                        filename2 := CONVERTSTR(filename2, '.', '_');
                        filename2 := CONVERTSTR(filename2, ',', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        FileCU.CopyClientFile(filename, HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename), true);
                        "Committe File Path" := HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename);
                        MESSAGE('File Attached Successfully');
                    end;
                end;
            }
            action("Attach File After Appeal")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = appealclosebl;

                trigger OnAction();
                begin
                    filename := FileCU.OpenFileDialog('Select  File', '', '');
                    if filename <> '' then begin
                        HRsetup.RESET;
                        HRsetup.GET;
                        filename2 := FORMAT(CURRENTDATETIME) + '_' + USERID;
                        filename2 := CONVERTSTR(filename2, '/', '_');
                        filename2 := CONVERTSTR(filename2, '\', '_');
                        filename2 := CONVERTSTR(filename2, ':', '_');
                        filename2 := CONVERTSTR(filename2, '.', '_');
                        filename2 := CONVERTSTR(filename2, ',', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        FileCU.CopyClientFile(filename, HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename), true);
                        "Committee File-After Appeal" := HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename);
                        MESSAGE('File Attached Successfully');
                    end;
                end;
            }

            action("Attach Warning Letter")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Visible = appealclosebl;

                trigger OnAction();
                begin
                    filename := FileCU.OpenFileDialog('Select  File', '', '');
                    if filename <> '' then begin
                        HRsetup.RESET;
                        HRsetup.GET;
                        filename2 := FORMAT(CURRENTDATETIME) + '_' + USERID;
                        filename2 := CONVERTSTR(filename2, '/', '_');
                        filename2 := CONVERTSTR(filename2, '\', '_');
                        filename2 := CONVERTSTR(filename2, ':', '_');
                        filename2 := CONVERTSTR(filename2, '.', '_');
                        filename2 := CONVERTSTR(filename2, ',', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        filename2 := CONVERTSTR(filename2, ' ', '_');
                        FileCU.CopyClientFile(filename, HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename), true);
                        "Warning Letter Attachment Path" := HRsetup."Disciplinary Cases File" + FileCU.GetFileName(filename);
                        MESSAGE('File Attached Successfully');
                    end;
                end;
            }

            action("Open Attached HOD File")
            {
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    if "HOD File Path" <> '' then begin
                        HYPERLINK("HOD File Path");
                    end;
                end;
            }
            action("Open Attached HR File")
            {
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    if "HR File Path" <> '' then begin
                        HYPERLINK("HR File Path");
                    end;
                end;
            }
            action("Open Attached Commitee File")
            {
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    if "Committe File Path" <> '' then begin
                        HYPERLINK("Committe File Path");
                    end;
                end;
            }
            action("Open Attached Warning Letter")
            {
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    if "Warning Letter Attachment Path" <> '' then begin
                        HYPERLINK("Warning Letter Attachment Path");
                    end;
                end;
            }
            action("Open File After Appeal")
            {
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = appealclosebl;

                trigger OnAction();
                begin
                    if "Committee File-After Appeal" <> '' then begin
                        HYPERLINK("Committee File-After Appeal");
                    end;
                end;
            }
            action("Close Case")
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Ongoingbl;

                trigger OnAction();
                begin
                    if "Action Taken" = '' then begin
                        ERROR('Fill Action Taken!!');
                    end;
                    if "Commitee Recommendation" = '' then begin
                        ERROR('Please Fill Commitee Recomendation!!');
                    end;

                    if "Action Taken" <> '' then begin
                        "Case Status" := "Case Status"::Closed;
                    end;

                    MESSAGE('Taken to Closed Cases');

                    CurrPage.CLOSE;
                end;
            }
            action("Appeal Case")
            {
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = closedbl;

                trigger OnAction();
                var
                    ans: Boolean;
                begin
                    ans := CONFIRM('Are you sure you want to Appeal this case?');
                    if FORMAT(ans) = 'Yes' then begin
                        "Case Status" := "Case Status"::Appealed;
                    end;
                    "No. of Appeals" += 1;
                    CurrPage.CLOSE;
                end;
            }
            action("Close Case After Appeal")
            {
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = appealedbl;

                trigger OnAction();
                begin
                    if "Committee Recon After Appeal" = '' then begin
                        ERROR('Please Fill Commitee Recommendation After Appeal!!!');
                    end;
                    "Case Status" := "Case Status"::Closed;
                    MESSAGE('Case moved to Closed Cases');
                    CurrPage.CLOSE;
                end;
            }
            action("HR Close Case")
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = openbl;

                trigger OnAction();
                begin
                    if "HR Recommendation" = '' then begin
                        ERROR('Fill HR Recommenation!!');
                    end;

                    //IF "Action Taken"<>'' THEN BEGIN
                    "Case Status" := "Case Status"::Closed;
                    //END;

                    MESSAGE('Taken to Closed Cases');

                    CurrPage.CLOSE;
                end;
            }
            action("Moved to Court")
            {
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    ans: Boolean;
                begin
                    ans := CONFIRM('Are you sure you want to move this case to court?');
                    if FORMAT(ans) = 'Yes' then begin
                        "Case Status" := "Case Status"::Court;
                    end;
                    //`"No. of Appeals"+=1;
                    CurrPage.CLOSE;
                end;
            }
            action("Close Case2")
            {
                Caption = 'Close Case';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = courtbl;

                trigger OnAction();
                begin
                    if "Court's Decision" = '' then begin
                        ERROR('Please Fill Courts Decision"!!');
                    end;
                    "Case Status" := "Case Status"::Closed;

                    MESSAGE('Taken to Closed Cases');

                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if "Case Status" <> "Case Status"::New then begin
            ERROR('You cannot Create a new Record at this level. Create it in New Cases Tab');
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        if "Case Status" <> "Case Status"::New then begin
            ERROR('You cannot Create a new Record at this level. Create it in New Cases Tab');
        end;
    end;

    trigger OnOpenPage();
    begin



        if "Case Status" = "Case Status"::Ongoing then begin
            ongoingbl := true;
        end;
        if "Case Status" = "Case Status"::Appealed then begin
            appealedbl := true;
        end;
        if "Case Status" = "Case Status"::Closed then begin
            closedbl := true;
        end;
        if "Case Status" = "Case Status"::New then begin
            openbl := true;
        end;
        if "Case Status" <> "Case Status"::New then begin
            openbl := false;
        end;
        if ("Case Status" = "Case Status"::Appealed) or ("Case Status" = "Case Status"::Closed) then begin
            appealclosebl := true;
        end;
        if ("Case Status" = "Case Status"::Closed) or ("Case Status" = "Case Status"::Court) then begin
            courtbl := true;
        end;
    end;

    var
        ongoingbl: Boolean;
        appealedbl: Boolean;
        closedbl: Boolean;
        openbl: Boolean;
        FileCU: Codeunit "File Management";
        filename: Text;
        HRsetup: Record "Human Resources Setup";
        filename2: Text;
        appealclosebl: Boolean;
        courtbl: Boolean;
}


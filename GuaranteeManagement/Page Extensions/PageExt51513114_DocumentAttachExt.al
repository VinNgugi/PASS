codeunit 51513813 DocumentAttachmnet
{
    trigger OnRun()
    begin

    end;

    var

        FromRecRef: RecordRef;
        FlowFieldsEditable: Boolean;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', true, true)]
    local procedure OpenForRecRefExt(RecRef: RecordRef)
    var

        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option;
        LineNo: Integer;
        Attachment: Record "Document Attachment";
    begin
        Attachment.RESET;

        FromRecRef := RecRef;

        Attachment.SETRANGE("Table ID", RecRef.NUMBER);

        CASE RecRef.NUMBER OF
            DATABASE::"Guarantee Application":
                BEGIN

                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    Attachment.Reset();
                    Attachment.SETRANGE("No.", RecNo);
                    FlowFieldsEditable := FALSE;
                END;
            DATABASE::"Guarantee Contracts":
                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    Attachment.Reset();
                    Attachment.VALIDATE("No.", RecNo);
                    Attachment.Insert(true);

                END;
        END;
    end;
    /*
        [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeInsertAttachment', '', true, true)]
        local procedure SaveAttachmentExt(RecRef: RecordRef)
        var

            FieldRef: FieldRef;
            DocStream: InStream;
            RecNo: Code[20];
            DocType: Option;
            LineNo: Integer;
            Attachment: Record "Document Attachment";
        begin
            CASE RecRef.NUMBER OF

                DATABASE::"Non-Wall Applications":
                    BEGIN
                        FieldRef := RecRef.FIELD(1);
                        RecNo := FieldRef.VALUE;
                        Attachment.Reset();
                        Attachment.VALIDATE("No.", RecNo);


                    END;
            END;
        end;*/

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeSaveAttachment', '', true, true)]
    local procedure BeforsSaveAttachmentExt(RecRef: RecordRef; FileName: Text; TempBlob: Record TempBlob)
    var
        FieldRef: FieldRef;
        DocStream: InStream;
        RecNo: Code[20];
        DocType: Option;
        LineNo: Integer;
        Attachment: Record "Document Attachment";

        FileManagement: Codeunit "File Management";
        IncomingFileName: Text;
        NoDocumentAttachedErr: TextConst ENU = 'Please attach a document first.';
        EmptyFileNameErr: TextConst ENU = 'Please choose a file to attach.';
        NoContentErr: TextConst ENU = 'The selected file has no content. Please choose another file.';
        DuplicateErr: TextConst ENU = 'This file is already attached to the document. Please choose another file.';
    begin
        IF FileName = '' THEN
            ERROR(EmptyFileNameErr);
        // Validate file/media is not empty
        IF NOT TempBlob.Blob.HASVALUE THEN
            ERROR(NoContentErr);

        IncomingFileName := FileName;

        Attachment.VALIDATE("File Extension", FileManagement.GetExtension(IncomingFileName));
        Attachment.VALIDATE("File Name", COPYSTR(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MAXSTRLEN(Attachment."File Name")));

        TempBlob.Blob.CREATEINSTREAM(DocStream);
        // IMPORTSTREAM(stream,description, mime-type,filename)
        // description and mime-type are set empty and will be automatically set by platform code from the stream
        Attachment."Document Reference ID".IMPORTSTREAM(DocStream, '', '', IncomingFileName);
        IF NOT Attachment."Document Reference ID".HASVALUE THEN
            ERROR(NoDocumentAttachedErr);

        Attachment.VALIDATE("Table ID", RecRef.NUMBER);

        CASE RecRef.NUMBER OF

            DATABASE::"Guarantee Application":
                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    Attachment.Reset();
                    Attachment.VALIDATE("No.", RecNo);
                    Attachment.Insert(true);

                END;
            DATABASE::"Guarantee Contracts":
                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    Attachment.Reset();
                    Attachment.VALIDATE("No.", RecNo);
                    Attachment.Insert(true);

                END;
        END;
    end;
}
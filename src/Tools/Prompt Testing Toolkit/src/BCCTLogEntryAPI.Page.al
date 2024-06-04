// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.TestTools.AITestToolkit;

page 149038 "BCCT Log Entry API"
{
    PageType = API;
    APIPublisher = 'microsoft';
    APIGroup = 'copilotTestToolkit';
    APIVersion = 'v1.0';

    Caption = 'BCCT Logs Entry API';

    EntityCaption = 'BCCTLogEntry';
    EntitySetCaption = 'BCCTLogEntry';
    EntityName = 'bcctLogEntry';
    EntitySetName = 'bcctLogEntries';

    SourceTable = "BCCT Log Entry";
    ODataKeyFields = SystemId;

    Extensible = false;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field("bcctCode"; Rec."BCCT Code")
                {
                    Caption = 'BCCT Code';
                    Editable = false;
                    NotBlank = true;
                    TableRelation = "BCCT Header";
                }
                field("lineNumber"; Rec."BCCT Line No.")
                {
                    Caption = 'Line No.';
                }
                field("tag"; Rec.Tag)
                {
                    Caption = 'Tag';
                }
                field("version"; Rec.Version)
                {
                    Caption = 'Version No.';
                }
                field("entryNumber"; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field("startTime"; Rec."Start Time")
                {
                    Caption = 'Start Time';
                }
                field("endTime"; Rec."End Time")
                {
                    Caption = 'End Time';
                }
                field("codeunitID"; Rec."Codeunit ID")
                {
                    Caption = 'Codeunit ID';
                }
                field("codeunitName"; Rec."Codeunit Name")
                {
                    Caption = 'Codeunit Name';
                }
                field("procedureName"; Rec."Procedure Name")
                {
                    Caption = 'Function Name';
                }
                field("operation"; Rec.Operation)
                {
                    Caption = 'Operation';
                }
                field("message"; Rec.Message)
                {
                    Caption = 'Message';
                }
                field("durationMin"; Rec."Duration (ms)")
                {
                    Caption = 'Duration (ms)';
                }
                field("status"; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(dataset; Rec."Test Input Group Code")
                {
                    Caption = 'Dataset';
                }
                field("datasetLineNumber"; Rec."Test Input Code")
                {
                    Caption = 'Dataset Line No.';
                }
                field("inputData"; this.InputText)
                {
                    Caption = 'Input Data';
                }
                field("outputData"; this.OutputText)
                {
                    Caption = 'Output Data';
                }
                // TODO metrics fields
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        this.InputText := Rec.GetInputBlob();
        this.OutputText := Rec.GetOutputBlob();
    end;

    var
        InputText: Text;
        OutputText: Text;
}
import Foundation

@testable import TestRailKit

/// This is just a series of json request/responses and used to try and make the tests cleaner to read than reems of chars everywhere

// Mark: Attachments

let b64image =
    "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"

let attachmentIdentifierResp = """
    {"attachment_id": 443}
    """

let attachmentForCaseResp = """
    {
        "id": 262,
        "name": "image.png",
        "size": 3158,
        "created_on": 1601049276,
        "project_id": 3,
        "case_id": 297,
        "user_id": 1,
        "result_id": null
    }
    """

// Mark: Attachments
let caseResp = """
    {
        "id": 294,
        "title": "UI - Some Important Test",
        "section_id": 82,
        "template_id": 2,
        "type_id": 7,
        "priority_id": 2,
        "milestone_id": null,
        "refs": null,
        "created_by": 1,
        "created_on": 1583263388,
        "updated_by": 9,
        "updated_on": 1601037642,
        "estimate": null,
        "estimate_forecast": null,
        "suite_id": 3,
        "display_order": 3,
        "custom_automation_type": 1,
        "custom_testrail_label": null,
        "custom_preconds": "Preconditions are...",
        "custom_steps": null,
        "custom_expected": null,
        "custom_steps_separated": [
            {
                "content": "Logon with username and \\npassword",
                "expected": "System worked"
            }
        ],
        "custom_mission": null,
        "custom_goals": null
    }
    """
let caseRequest = TestRailCase(
    id: nil, title: "API Added Test", sectionId: 82, templateId: 2, typeId: 7, priorityId: 2, milestoneId: nil, refs: nil,
    createdBy: 1, createdOn: Date(timeIntervalSince1970: 1_583_263_388), updatedBy: 9,
    updatedOn: Date(timeIntervalSince1970: 1_601_037_642), estimate: nil, estimateForecast: nil, suiteId: 3, displayOrder: 3,
    customAutomationType: 1, customTestrailLabel: nil, customPreconds: "Preconditions are...", customSteps: nil,
    customExpected: nil,
    customStepsSeparated: [TestRailStep(content: "Logon with username and Password", expected: "Everything Works")],
    customMission: nil, customGoals: nil)

//let updateCaseObject = UpdatedCase(propertyId: 5)

// Mark: CaseFields
let newCaseFieldObject = TestRailNewCaseField(
    type: .multiselect, name: "Brand New Case", label: "Case Label", description: "very descriptive", includeAll: true,
    templateIds: [],
    config: CaseFieldConfig(
        context: CaseFieldContext(isGlobal: true, projectIds: [1]),
        options: CaseFieldOptions(isRequired: true, defaultValue: nil, format: nil, rows: nil, items: nil), id: nil))

let caseFieldResponse = """
    {
            "id": 1,
            "is_active": true,
            "type_id": 3,
            "name": "preconds",
            "system_name": "custom_preconds",
            "label": "Preconditions",
            "description": "The preconditions of this test case. Reference other test cases with [C#] (e.g. [C17]).",
            "configs": [
                {
                    "context": {
                        "is_global": true,
                        "project_ids": null
                    },
                    "options": {
                        "is_required": false,
                        "default_value": "",
                        "format": "markdown",
                        "rows": "7"
                    },
                    "id": "4be1344d55d11"
                }
            ],
            "display_order": 1,
            "include_all": false,
            "template_ids": [
                1,
                2
            ]
        }
    """

let addedCaseFieldResponse =
    #"""
    {
      "id": 15,
      "name": "my_multiselect",
      "system_name": "custom_my_multiselect",
      "entity_id": 1,
      "label": "My Multiselect",
      "description": "my custom Multiselect description",
      "type_id": 12,
      "location_id": 2,
      "display_order": 7,
      "configs": "[{\"context\":{\"is_global\":true,\"project_ids\":\"\"},\"options\":{\"is_required\":false,\"items\":\"1, One\\n2, Two\"},\"id\":\"b44a4590-6075-43cd-b5d7-352c41aa54b7\"}]",
      "is_multi": 1,
      "is_active": 1,
      "status_id": 1,
      "is_system": 0,
      "include_all": 1,
      "template_ids": []
    }
    """#

// Mark: CaseType
let caseTypeResponses = """
    [
    {
            "id": 1,
            "is_default": false,
            "name": "Automated"
        },
        {
            "id": 2,
            "is_default": false,
            "name": "Functionality"
        },
        {
            "id": 6,
            "is_default": true,
            "name": "Other"
        }
    ]
    """

// Mark: Configurations
let configResponse = """
    [
        {
            "configs": [
                {
                    "group_id": 1,
                    "id": 1,
                    "name": "Chrome"
                },
                {
                    "group_id": 1,
                    "id": 2,
                    "name": "Firefox"
                },
                {
                    "group_id": 1,
                    "id": 3,
                    "name": "Internet Explorer"
                }
            ],
            "id": 1,
            "name": "Browsers",
            "project_id": 1
        },
        {
            "configs": [
                {
                    "group_id": 2,
                    "id": 6,
                    "name": "Ubuntu 12"
                },
                {
                    "group_id": 2,
                    "id": 4,
                    "name": "Windows 7"
                },
                {
                    "group_id": 2,
                    "id": 5,
                    "name": "Windows 8"
                }
            ],
            "id": 2,
            "name": "Operating Systems",
            "project_id": 1
        }
    ]
    """

let addConfigGroupResponse = """
    {
        "id":1,
        "name":"Browsers",
        "project_id":1,
        "configs":[]
    }
    """

let addConfigResponse = """
    {
        "id":1,
        "name":"Chrome",
        "group_id":1
    }
    """

let updatedConfifGroupResponse = """
    {
    "id":1,
    "name":"OS",
    "project_id":1,
    "configs":[
        {"id":1,
        "name":"Chrome",
        "group_id":1
        }]
        }
    """

let updatedConfigResponse = """
    {"id":1,"name":"Mac OS","group_id":1}
    """

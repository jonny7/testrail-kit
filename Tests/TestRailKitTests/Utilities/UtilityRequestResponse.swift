import Foundation

@testable import TestRailKit

/// This is just a series of json request/responses and used to try and make the tests cleaner to read than reems of chars everywhere

// MARK: Attachments

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

// MARK: Attachments
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
let caseRequest = Case(
    id: nil, title: "API Added Test", sectionId: 82, templateId: 2, typeId: 7, priorityId: 2, milestoneId: nil, refs: nil,
    createdBy: 1, createdOn: Date(timeIntervalSince1970: 1_583_263_388), updatedBy: 9,
    updatedOn: Date(timeIntervalSince1970: 1_601_037_642), estimate: nil, estimateForecast: nil, suiteId: 3, displayOrder: 3,
    customAutomationType: 1, customTestrailLabel: nil, customPreconds: "Preconditions are...", customSteps: nil,
    customExpected: nil,
    customStepsSeparated: [CaseStep(content: "Logon with username and Password", expected: "Everything Works")],
    customMission: nil, customGoals: nil)

let caseWithHistoryResponse = """
{
        "id": 64,
        "type_id": 6,
        "created_on": 1573844969,
        "user_id": 2,
        "changes": [
            {
                "type_id": 1,
                "field": "title",
                "old_value": "Search for Something",
                "new_value": "Search for Something using a label"
            },
            {
                "type_id": 6,
                "old_text": null,
                "new_text": null,
                "label": "Steps",
                "options": {
                    "is_required": false,
                    "default_value": "",
                    "format": "markdown",
                    "rows": "7"
                },
                "field": "custom_steps",
                "old_value": "search for user with ID 5",
                "new_value": "1. Click on search \\r\\n2. 2. Enter test person ID and click Search"
            },
            {
                "type_id": 6,
                "old_text": null,
                "new_text": null,
                "label": "Expected Result",
                "options": {
                    "is_required": false,
                    "default_value": "",
                    "format": "markdown",
                    "rows": "7"
                },
                "field": "custom_expected",
                "old_value": "Person should be found",
                "new_value": "Person should be found with correct ID"
            }
        ]
    }
"""

// MARK: CaseFields
let newCaseFieldObject = NewCaseField(
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

// MARK: CaseType
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

// MARK: Configurations
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

// MARK: Milestones

let addedMilestoneResponse = """
{
    "id": 4,
    "name": "Release 2.0",
    "description": null,
    "start_on": null,
    "started_on": 1602068972,
    "is_started": true,
    "due_on": 1394596385,
    "is_completed": false,
    "completed_on": null,
    "project_id": 3,
    "parent_id": null,
    "refs": null,
    "url": "https://me.testrail.io/index.php?/milestones/view/4",
    "milestones": []
}
"""

let embeddedMilestoneResponse = """
{
    "id": 4,
    "name": "Release 2.0",
    "description": null,
    "start_on": null,
    "started_on": 1602068972,
    "is_started": true,
    "due_on": 1394596385,
    "is_completed": false,
    "completed_on": null,
    "project_id": 3,
    "parent_id": null,
    "refs": null,
    "url": "https://me.testrail.io/index.php?/milestones/view/4",
    "milestones": [
{
    "id": 15,
    "name": "Sub Milestone",
    "description": null,
    "start_on": null,
    "started_on": 1602068972,
    "is_started": true,
    "due_on": 1394596385,
    "is_completed": false,
    "completed_on": null,
    "project_id": 3,
    "parent_id": null,
    "refs": null,
    "url": "https://me.testrail.io/index.php?/milestones/view/4",
}]
}
"""

let updatedMilestoneResponse = """
{
    "id": 4,
    "name": "Release 2.0",
    "description": null,
    "start_on": null,
    "started_on": 1602068972,
    "is_started": true,
    "due_on": 1394596385,
    "is_completed": true,
    "completed_on": null,
    "project_id": 3,
    "parent_id": null,
    "refs": null,
    "url": "https://me.testrail.io/index.php?/milestones/view/4",
    "milestones": []
}
"""

// MARK: Plan
let getPlanResponse = """
{
    "id": 88,
    "name": "1.0 Test Plan",
    "description": null,
    "milestone_id": 3,
    "assignedto_id": null,
    "is_completed": false,
    "completed_on": null,
    "passed_count": 1477,
    "blocked_count": 0,
    "untested_count": 991,
    "retest_count": 0,
    "failed_count": 65,
    "custom_status1_count": 0,
    "custom_status2_count": 0,
    "custom_status3_count": 0,
    "custom_status4_count": 0,
    "custom_status5_count": 0,
    "custom_status6_count": 0,
    "custom_status7_count": 0,
    "project_id": 3,
    "created_on": 1597405632,
    "created_by": 1,
    "url": "https://me.testrail.io/index.php?/plans/view/88",
    "entries": [
        {
            "id": "ec367af5-14d0-417a-83ed-9afce205d197",
            "suite_id": 6,
            "name": "API Testing",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 89,
                    "suite_id": 6,
                    "name": "API Testing",
                    "description": null,
                    "milestone_id": 3,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 952,
                    "blocked_count": 0,
                    "untested_count": 133,
                    "retest_count": 0,
                    "failed_count": 50,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 3,
                    "plan_id": 88,
                    "entry_index": 1,
                    "entry_id": "ec367af5-14d0-417a-83ed-9afce205d197",
                    "config": null,
                    "config_ids": [],
                    "created_on": 1597405960,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/plans/view/89"
                }
            ]
        },
        {
            "id": "0b6ed487-cb44-4c5e-b1f1-a2245009029c",
            "suite_id": 18,
            "name": "UI - v1.2.3",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 105,
                    "suite_id": 18,
                    "name": "Smoke",
                    "description": null,
                    "milestone_id": 3,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 9,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 3,
                    "plan_id": 88,
                    "entry_index": 11,
                    "entry_id": "0b6ed487-cb44-4c5e-b1f1-a2245009029c",
                    "config": "Firefox",
                    "config_ids": [
                        4
                    ],
                    "created_on": 1597410021,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/105"
                },
                {
                    "id": 106,
                    "suite_id": 18,
                    "name": "Smoke",
                    "description": null,
                    "milestone_id": 3,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 9,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 3,
                    "plan_id": 88,
                    "entry_index": 11,
                    "entry_id": "0b6ed487-cb44-4c5e-b1f1-a2245009029c",
                    "config": "Internet Explorer",
                    "config_ids": [
                        3
                    ],
                    "created_on": 1597410021,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/106"
                }
            ]
        }
    ]
}
"""

let getPlansResponse = """
[
    {
        "id": 88,
        "name": "2.0 Testing",
        "description": null,
        "milestone_id": 3,
        "assignedto_id": null,
        "is_completed": false,
        "completed_on": null,
        "passed_count": 1477,
        "blocked_count": 0,
        "untested_count": 991,
        "retest_count": 0,
        "failed_count": 65,
        "custom_status1_count": 0,
        "custom_status2_count": 0,
        "custom_status3_count": 0,
        "custom_status4_count": 0,
        "custom_status5_count": 0,
        "custom_status6_count": 0,
        "custom_status7_count": 0,
        "project_id": 3,
        "created_on": 1597405632,
        "created_by": 1,
        "url": "https://me.testrail.io/index.php?/plans/view/88"
    }
]
"""

let addedPlanResponse = """
{
    "id": 109,
    "name": "System test",
    "description": null,
    "milestone_id": null,
    "assignedto_id": null,
    "is_completed": false,
    "completed_on": null,
    "passed_count": 0,
    "blocked_count": 0,
    "untested_count": 12,
    "retest_count": 0,
    "failed_count": 0,
    "custom_status1_count": 0,
    "custom_status2_count": 0,
    "custom_status3_count": 0,
    "custom_status4_count": 0,
    "custom_status5_count": 0,
    "custom_status6_count": 0,
    "custom_status7_count": 0,
    "project_id": 2,
    "created_on": 1602263105,
    "created_by": 1,
    "url": "https://me.testrail.io/index.php?/plans/view/109",
    "entries": [
        {
            "id": "5b8d5332-1f83-4c58-9072-b408745c508e",
            "suite_id": 2,
            "name": "Custom run name",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 110,
                    "suite_id": 2,
                    "name": "Custom run name",
                    "description": null,
                    "milestone_id": null,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 6,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 2,
                    "plan_id": 109,
                    "entry_index": 1,
                    "entry_id": "5b8d5332-1f83-4c58-9072-b408745c508e",
                    "config": null,
                    "config_ids": [],
                    "created_on": 1602263105,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/110"
                }
            ]
        },
        {
            "id": "20d23a59-4d7f-4e4e-bdf3-678f12eb6d3a",
            "suite_id": 2,
            "name": "Another Run",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 111,
                    "suite_id": 2,
                    "name": "Another Run",
                    "description": null,
                    "milestone_id": null,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 6,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 2,
                    "plan_id": 109,
                    "entry_index": 2,
                    "entry_id": "20d23a59-4d7f-4e4e-bdf3-678f12eb6d3a",
                    "config": null,
                    "config_ids": [],
                    "created_on": 1602263105,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/111"
                }
            ]
        }
    ]
}
"""

let addedPlanEntry = """
{
    "id": "d82b6860-bef7-4efb-a09e-441b4a9f3a60",
    "runs": [
        {
            "id": 112,
            "suite_id": 2,
            "name": "Added Plan To Entry",
            "description": null,
            "milestone_id": null,
            "assignedto_id": null,
            "include_all": true,
            "is_completed": false,
            "completed_on": null,
            "passed_count": 0,
            "blocked_count": 0,
            "untested_count": 6,
            "retest_count": 0,
            "failed_count": 0,
            "custom_status1_count": 0,
            "custom_status2_count": 0,
            "custom_status3_count": 0,
            "custom_status4_count": 0,
            "custom_status5_count": 0,
            "custom_status6_count": 0,
            "custom_status7_count": 0,
            "project_id": 2,
            "plan_id": 109,
            "entry_index": 3,
            "entry_id": "d82b6860-bef7-4efb-a09e-441b4a9f3a60",
            "config": null,
            "config_ids": [],
            "created_on": 1602263417,
            "refs": null,
            "created_by": 1,
            "url": "https://me.testrail.io/index.php?/runs/view/112"
        }
    ],
    "suite_id": 2,
    "name": "Added Plan To Entry",
    "description": null,
    "include_all": true
}
"""

let addedRunToPlanEntryResponseString = """
{
    "id": 109,
    "name": "System test",
    "description": null,
    "milestone_id": null,
    "assignedto_id": null,
    "is_completed": false,
    "completed_on": null,
    "passed_count": 0,
    "blocked_count": 0,
    "untested_count": 18,
    "retest_count": 0,
    "failed_count": 0,
    "custom_status1_count": 0,
    "custom_status2_count": 0,
    "custom_status3_count": 0,
    "custom_status4_count": 0,
    "custom_status5_count": 0,
    "custom_status6_count": 0,
    "custom_status7_count": 0,
    "project_id": 2,
    "created_on": 1602263105,
    "created_by": 1,
    "url": "https://me.testrail.io/index.php?/plans/view/109",
    "entries": [
        {
            "id": "20d23a59-4d7f-4e4e-bdf3-678f12eb6d3a",
            "suite_id": 2,
            "name": "Another Run",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 111,
                    "suite_id": 2,
                    "name": "Another Run",
                    "description": null,
                    "milestone_id": null,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 6,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 2,
                    "plan_id": 109,
                    "entry_index": 2,
                    "entry_id": "20d23a59-4d7f-4e4e-bdf3-678f12eb6d3a",
                    "config": null,
                    "config_ids": [],
                    "created_on": 1602263105,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/111"
                }
            ]
        },
        {
            "id": "5b8d5332-1f83-4c58-9072-b408745c508e",
            "suite_id": 2,
            "name": "Custom run name",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 113,
                    "suite_id": 2,
                    "name": "Custom run name",
                    "description": null,
                    "milestone_id": null,
                    "assignedto_id": null,
                    "include_all": false,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 0,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 2,
                    "plan_id": 109,
                    "entry_index": 3,
                    "entry_id": "5b8d5332-1f83-4c58-9072-b408745c508e",
                    "config": "b",
                    "config_ids": [
                        6
                    ],
                    "created_on": 1602264451,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/113"
                }
            ]
        },
        {
            "id": "d82b6860-bef7-4efb-a09e-441b4a9f3a60",
            "suite_id": 2,
            "name": "Added Plan To Entry",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 112,
                    "suite_id": 2,
                    "name": "Added Plan To Entry",
                    "description": null,
                    "milestone_id": null,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 6,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 2,
                    "plan_id": 109,
                    "entry_index": 3,
                    "entry_id": "d82b6860-bef7-4efb-a09e-441b4a9f3a60",
                    "config": null,
                    "config_ids": [],
                    "created_on": 1602263417,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/112"
                }
            ]
        }
    ]
}
"""

let updatedPlanResponse = """
{
    "id": 88,
    "name": "Updated Plan",
    "description": null,
    "milestone_id": 3,
    "assignedto_id": null,
    "is_completed": false,
    "completed_on": null,
    "passed_count": 1477,
    "blocked_count": 0,
    "untested_count": 991,
    "retest_count": 0,
    "failed_count": 65,
    "custom_status1_count": 0,
    "custom_status2_count": 0,
    "custom_status3_count": 0,
    "custom_status4_count": 0,
    "custom_status5_count": 0,
    "custom_status6_count": 0,
    "custom_status7_count": 0,
    "project_id": 3,
    "created_on": 1597405632,
    "created_by": 1,
    "url": "https://me.testrail.io/index.php?/plans/view/88",
    "entries": [
        {
            "id": "ec367af5-14d0-417a-83ed-9afce205d197",
            "suite_id": 6,
            "name": "API Testing",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 89,
                    "suite_id": 6,
                    "name": "API Testing",
                    "description": null,
                    "milestone_id": 3,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 952,
                    "blocked_count": 0,
                    "untested_count": 133,
                    "retest_count": 0,
                    "failed_count": 50,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 3,
                    "plan_id": 88,
                    "entry_index": 1,
                    "entry_id": "ec367af5-14d0-417a-83ed-9afce205d197",
                    "config": null,
                    "config_ids": [],
                    "created_on": 1597405960,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/plans/view/89"
                }
            ]
        },
        {
            "id": "0b6ed487-cb44-4c5e-b1f1-a2245009029c",
            "suite_id": 18,
            "name": "UI - v1.2.3",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 105,
                    "suite_id": 18,
                    "name": "Smoke",
                    "description": null,
                    "milestone_id": 3,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 9,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 3,
                    "plan_id": 88,
                    "entry_index": 11,
                    "entry_id": "0b6ed487-cb44-4c5e-b1f1-a2245009029c",
                    "config": "Firefox",
                    "config_ids": [
                        4
                    ],
                    "created_on": 1597410021,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/105"
                },
                {
                    "id": 106,
                    "suite_id": 18,
                    "name": "Smoke",
                    "description": null,
                    "milestone_id": 3,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 9,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 3,
                    "plan_id": 88,
                    "entry_index": 11,
                    "entry_id": "0b6ed487-cb44-4c5e-b1f1-a2245009029c",
                    "config": "Internet Explorer",
                    "config_ids": [
                        3
                    ],
                    "created_on": 1597410021,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/106"
                }
            ]
        }
    ]
}
"""

let updatedPlanEntryResponse = """
{
    "id": "ec367af5-14d0-417a-83ed-9afce205d197",
    "runs": [
        {
            "id": 89,
            "suite_id": 6,
            "name": "Updated Plan Entry",
            "description": null,
            "milestone_id": 3,
            "assignedto_id": null,
            "include_all": true,
            "is_completed": false,
            "completed_on": null,
            "passed_count": 952,
            "blocked_count": 0,
            "untested_count": 133,
            "retest_count": 0,
            "failed_count": 50,
            "custom_status1_count": 0,
            "custom_status2_count": 0,
            "custom_status3_count": 0,
            "custom_status4_count": 0,
            "custom_status5_count": 0,
            "custom_status6_count": 0,
            "custom_status7_count": 0,
            "project_id": 3,
            "plan_id": 88,
            "entry_index": 1,
            "entry_id": "ec367af5-14d0-417a-83ed-9afce205d197",
            "config": null,
            "config_ids": [],
            "created_on": 1597405960,
            "refs": null,
            "created_by": 1,
            "url": "https://me.testrail.io/index.php?/runs/view/89"
        }
    ],
    "suite_id": 6,
    "name": "Updated Plan Entry",
    "description": null,
    "include_all": true
}
"""

let updateRunInPlanEntryResponseString = """
{
    "id": 109,
    "name": "System test",
    "description": null,
    "milestone_id": null,
    "assignedto_id": null,
    "is_completed": false,
    "completed_on": null,
    "passed_count": 0,
    "blocked_count": 0,
    "untested_count": 12,
    "retest_count": 0,
    "failed_count": 0,
    "custom_status1_count": 0,
    "custom_status2_count": 0,
    "custom_status3_count": 0,
    "custom_status4_count": 0,
    "custom_status5_count": 0,
    "custom_status6_count": 0,
    "custom_status7_count": 0,
    "project_id": 2,
    "created_on": 1602263105,
    "created_by": 1,
    "url": "https://me.testrail.io/index.php?/plans/view/109",
    "entries": [
        {
            "id": "20d23a59-4d7f-4e4e-bdf3-678f12eb6d3a",
            "suite_id": 2,
            "name": "Another Run",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 111,
                    "suite_id": 2,
                    "name": "Another Run",
                    "description": null,
                    "milestone_id": null,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 6,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 2,
                    "plan_id": 109,
                    "entry_index": 2,
                    "entry_id": "20d23a59-4d7f-4e4e-bdf3-678f12eb6d3a",
                    "config": null,
                    "config_ids": [],
                    "created_on": 1602263105,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/111"
                }
            ]
        },
        {
            "id": "5b8d5332-1f83-4c58-9072-b408745c508e",
            "suite_id": 2,
            "name": "Custom run name",
            "refs": "",
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 113,
                    "suite_id": 2,
                    "name": "Custom run name",
                    "description": "Updated Plan Entry Run",
                    "milestone_id": null,
                    "assignedto_id": null,
                    "include_all": false,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 0,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 2,
                    "plan_id": 109,
                    "entry_index": 3,
                    "entry_id": "5b8d5332-1f83-4c58-9072-b408745c508e",
                    "config": "b",
                    "config_ids": [
                        6
                    ],
                    "created_on": 1602264451,
                    "refs": "",
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/113"
                }
            ]
        },
        {
            "id": "d82b6860-bef7-4efb-a09e-441b4a9f3a60",
            "suite_id": 2,
            "name": "Added Plan To Entry",
            "refs": null,
            "description": null,
            "include_all": true,
            "runs": [
                {
                    "id": 112,
                    "suite_id": 2,
                    "name": "Added Plan To Entry",
                    "description": null,
                    "milestone_id": null,
                    "assignedto_id": null,
                    "include_all": true,
                    "is_completed": false,
                    "completed_on": null,
                    "passed_count": 0,
                    "blocked_count": 0,
                    "untested_count": 6,
                    "retest_count": 0,
                    "failed_count": 0,
                    "custom_status1_count": 0,
                    "custom_status2_count": 0,
                    "custom_status3_count": 0,
                    "custom_status4_count": 0,
                    "custom_status5_count": 0,
                    "custom_status6_count": 0,
                    "custom_status7_count": 0,
                    "project_id": 2,
                    "plan_id": 109,
                    "entry_index": 3,
                    "entry_id": "d82b6860-bef7-4efb-a09e-441b4a9f3a60",
                    "config": null,
                    "config_ids": [],
                    "created_on": 1602263417,
                    "refs": null,
                    "created_by": 1,
                    "url": "https://me.testrail.io/index.php?/runs/view/112"
                }
            ]
        }
    ]
}
"""

// MARK: Priorities
let priorityResponseString = """
[
    {
        "id": 1,
        "is_default": false,
        "name": "1 - Don't Test",
        "priority": 1,
        "short_name": "1 - Don't"
    }
]
"""

// MARK: Projects
let projectResponseString = """
{
    "id": 3,
    "name": "iOS",
    "announcement": null,
    "show_announcement": false,
    "is_completed": false,
    "completed_on": null,
    "suite_mode": 3,
    "url": "https://me.testrail.io/index.php?/projects/overview/3"
}
"""

// MARK: Reports
let getReportsString = """
[
    {
        "id": 1,
        "name": "Activity Summary (Cases) %date%",
        "description": null,
        "notify_user": false,
        "notify_link": false,
        "notify_link_recipients": null,
        "notify_attachment": false,
        "notify_attachment_recipients": "person1@example.com\\r\\nperson2@example.com",
        "notify_attachment_html_format": false,
        "notify_attachment_pdf_format": false,
        "cases_groupby": "day",
        "changes_daterange": "5",
        "changes_daterange_from": null,
        "changes_daterange_to": null,
        "suites_include": "1",
        "suites_ids": null,
        "sections_include": "1",
        "sections_ids": null,
        "cases_columns": {
            "cases:id": 75,
            "cases:title": 0,
            "cases:created_by": 125,
            "cases:updated_by": 125
        },
        "cases_filters": null,
        "cases_limit": 1000,
        "content_hide_links": false,
        "cases_include_new": true,
        "cases_include_updated": true
    }
]
"""

let runReportResponseString = """
{
    "report_url": "https://docs.testrail.com/index.php?/reports/view/383",
    "report_html": "https://docs.testrail.com/index.php?/reports/get_html/383",
    "report_pdf": "https://docs.testrail.com/index.php?/reports/get_pdf/383"
}
"""

// MARK: Results
let resultForTestResponseString = """
    {
        "id": 9436,
        "test_id": 104536,
        "status_id": 1,
        "created_on": 1600971013,
        "assignedto_id": null,
        "comment": "![](index.php?/attachments/get/251)\\n",
        "version": null,
        "elapsed": null,
        "defects": null,
        "custom_step_results": [
            {
                "content": "Step 1 Record something important",
                "expected": "I expect it done",
                "actual": "Yay!",
                "status_id": 1
            }
        ],
        "attachment_ids": [
            251
        ]
    }
"""

let resultsForCaseResponseString = """
[
    {
        "id": 8722,
        "test_id": 103641,
        "status_id": 1,
        "created_on": 1598968324,
        "assignedto_id": null,
        "comment": null,
        "version": null,
        "elapsed": null,
        "defects": null,
        "custom_step_results": null,
        "attachment_ids": []
    }
]
"""

let addTestResult = NewTestResult(statusId: .passed, comment: "IDs don't match", version: nil, elapsed: nil, defects: nil, assignedTo: 5, customStepResults: [StepResult(content: "Step 1 Record something important", expected: nil, actual: nil, statusId: .failed)])

let addMultipleTestResults = AddMultipleTestResults(results: [NewTestResult(testId: 271188, statusId: .failed, comment: "This test fails", version: "1.0 RC", elapsed: "15s", defects: "TR-7", assignedTo: nil, customStepResults: [StepResult(content: "Launch App from desktop", expected: "It works", actual: "Works", statusId: .passed)])])

let addedMultipleTestsResponseString = """
[
    {
        "id": 12509,
        "test_id": 271188,
        "status_id": 5,
        "created_on": 1603552928,
        "assignedto_id": null,
        "comment": "This test failed",
        "version": "1.0 RC1 build 3724",
        "elapsed": "15s",
        "defects": "TR-7",
        "custom_step_results": [
            {
                "content": "Launch App from desktop",
                "expected": "It works",
                "actual": "Works",
                "status_id": 1
            }
        ],
        "attachment_ids": []
    }
]
"""

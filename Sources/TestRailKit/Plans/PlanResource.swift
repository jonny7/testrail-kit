import Foundation

public enum PlanResource: ConfigurationRepresentable {

    /// Returns an existing test plan.
    /// where `identifier` is either `planId` or `projectId` depending on a single or multiple object return
    /// See  https://www.gurock.com/testrail/docs/api/reference/plans#get_plan
    case get(identifier: Int, type: RecordAction)

    case add(type: AddPlanAction)
    
    case update(type: UpdatePlanAction)

    public var request: RequestDetails {
        switch self {
        case .get(let identifier, let type):
            guard case .one = type else {
                return (uri: "get_plans/\(identifier)", .GET)
            }
            return (uri: "get_plan/\(identifier)", .GET)
        case .add(.plan(let projectId)):
            return (uri: "add_plan/\(projectId)", .POST)
        case .add(.planEntry(let planId)):
            return (uri: "add_plan_entry/\(planId)", .POST)
        case .add(.runToPlanEntry(let planId, let entryId)):
            return (uri: "add_run_to_plan_entry/\(planId)/\(entryId.uuidString.lowercased())", .POST)
        case .update(type: .plan(let planId)):
            return (uri: "update_plan/\(planId)", .POST)
        case .update(type: .planEntry(let planId, let entryId)):
            return (uri: "update_plan_entry/\(planId)/\(entryId.uuidString.lowercased())", .POST)
        case .update(type: .runInPlanEntry(let runId)):
            return (uri: "update_run_in_plan_entry/\(runId)", .POST)
        }
    }
    
    public enum AddPlanAction {
        case plan(projectId: Int)
        case planEntry(planId: Int)
        case runToPlanEntry(planId: Int, entryId: UUID)
    }
    
    public enum UpdatePlanAction {
        case plan(planId: Int)
        case planEntry(planId: Int, entryId: UUID)
        case runInPlanEntry(runId: Int)
    }
}

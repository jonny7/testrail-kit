import Foundation

public enum PlanResource: ConfigurationRepresentable {

    /// Returns an existing test plan.
    /// where `identifier` is either `planId` or `projectId` depending on a single or multiple object return
    /// See  https://www.gurock.com/testrail/docs/api/reference/plans#get_plan
    case get(identifier: Int, type: RecordAction)

    case add(type: AddPlanAction)
    
    case update(type: UpdatePlanAction)
    
    /// Closes an existing test plan and archives its test runs & results.
    /// See https://www.gurock.com/testrail/docs/api/reference/plans#close_plan
    case close(planId: Int)
    
    case delete(type: DeleteAction)

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
        case .close(let planId):
            return (uri: "close_plan/\(planId)", .POST)
        case .delete(.plan(let planId)):
            return (uri: "delete_plan/\(planId)", .POST)
        case .delete(type: .planEntry(let planId, let entryId)):
            return (uri: "delete_plan_entry/\(planId)/\(entryId.uuidString.lowercased())", .POST)
        case .delete(type: .runInPlanEntry(let runId)):
            return (uri: "delete_run_from_plan_entry/\(runId)", .POST)
        }
    }
    
    public enum AddPlanAction {
        /// Add a Plan
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#add_plan
        case plan(projectId: Int)
        
        /// Add a Plan Entry
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#add_plan_entry
        case planEntry(planId: Int)
        
        /// Add a run to a Plan Entry
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#add_run_to_plan_entry
        case runToPlanEntry(planId: Int, entryId: UUID)
    }
    
    public enum UpdatePlanAction {
        
        /// Updates a Plan
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#update_plan
        case plan(planId: Int)
        
        /// Update a Plan Entry
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#update_plan_entry
        case planEntry(planId: Int, entryId: UUID)
        
        /// Update Run in Plan Entry
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#update_run_in_plan_entry
        case runInPlanEntry(runId: Int)
    }
    
    public enum DeleteAction {
        
        /// Deletes a Plam
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#delete_plan
        case plan(planId: Int)
        
        /// Delete a Plan Entry
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#delete_plan_entry
        case planEntry(planId: Int, entryId: UUID)
        
        /// Deletes a run in a plan entry
        /// See https://www.gurock.com/testrail/docs/api/reference/plans#delete_run_from_plan_entry
        case runInPlanEntry(runId: Int)
    }
}

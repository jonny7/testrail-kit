public enum TestRailFilterOption {
  case created_after
  case created_before
  case created_by
  case filter
  case limit
  case milestone_id
  case offset
  case priority_id
  case section_id
  case template_id
  case type_id
  case updated_after
  case updated_before
  case updated_by

  var description: String {
    switch self {
    case .created_after:
      return "&created_after="
    case .created_before:
      return "&created_before="
    case .created_by:
      return "&created_by="
    case .filter:
      return "&filter="
    case .limit:
      return "&limit="
    case .milestone_id:
      return "&milestone_id="
    case .offset:
      return "&offset="
    case .priority_id:
      return "&priority_id="
    case .section_id:
      return "&section_id="
    case .template_id:
      return "&template_id="
    case .type_id:
      return "&type_id="
    case .updated_after:
      return "&updated_after="
    case .updated_before:
      return "&updated_before="
    case .updated_by:
      return "&updated_by="
    }
  }
}

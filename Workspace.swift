import ProjectDescription

let workspace = Workspace(
    name: "Demo",
    projects: [
        "App",
        "Data",
        "Domain",
        "HTTP",
        "Resources",
    ],
    generationOptions: .options(autogeneratedWorkspaceSchemes: .disabled)
)

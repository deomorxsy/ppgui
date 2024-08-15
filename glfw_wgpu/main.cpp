#include "../assets/imgui/imgui.h"
#include "../assets/implot/implot.h"
#include "../assets/imgui/backends/imgui_impl_glfw.h"
#include "../assets/imgui/backends/imgui_impl_opengl3.h"
#include <GLFW/glfw3.h> // Include glfw3.h after our OpenGL definitions

// Callback for rendering
void RenderGraph()
{
    ImGui::Begin("Trace Graph Example");

    if (ImPlot::BeginPlot("Trace Timeline"))
    {
        // Example data
        static float x_data[10] = {0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f, 9.0f};
        static float y_data[10] = {1.0f, 3.0f, 2.0f, 4.0f, 6.0f, 5.0f, 7.0f, 9.0f, 8.0f, 10.0f};

        ImPlot::PlotLine("Trace", x_data, y_data, 10);
        ImPlot::EndPlot();
    }

    ImGui::End();
}

int main()
{
    // Setup GLFW
    if (!glfwInit())
        return -1;
    GLFWwindow* window = glfwCreateWindow(1280, 720, "ImPlot Example", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSwapInterval(1); // Enable vsync

    // Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    // Setup Dear ImGui style
    ImGui::StyleColorsDark();

    // Setup Platform/Renderer bindings
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init("#version 130");

    // Setup ImPlot
    ImPlot::CreateContext();

    // Main loop
    while (!glfwWindowShouldClose(window))
    {
        // Poll and handle events
        glfwPollEvents();

        // Start the ImGui frame
        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();

        // Render graph
        RenderGraph();

        // Rendering
        ImGui::Render();
        int display_w, display_h;
        glfwGetFramebufferSize(window, &display_w, &display_h);
        glViewport(0, 0, display_w, display_h);
        glClearColor(0.45f, 0.55f, 0.60f, 1.00f);
        glClear(GL_COLOR_BUFFER_BIT);
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

        // Swap buffers
        glfwSwapBuffers(window);
    }

    // Cleanup
    ImPlot::DestroyContext();
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();
    glfwDestroyWindow(window);
    glfwTerminate();

    return 0;
}


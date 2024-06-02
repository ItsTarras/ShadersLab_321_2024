/* In Task 10, you will be adding code this surface shader
 * to modify the stencil buffer to create "XRay" textures
 * which allow us to see through objects
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task10/XRayStencilShaderLevel1"
{
    // We have no unity Inspector properties
    // We could add a colour if we wanted
    Properties {}

    SubShader
    {
        /*******
         * TODO: Sub Task 2 Set the Render Queue to something less
         * than our XRay Stencil Test Objects, using the
         * Tags { "Queue" = "..." } function
         *******/
         Tags {"Queue" = "Geometry-1"}

        // The shader details
        Stencil
        {
            /*******
             * TODO: Sub Task 1 Set the ref value to 1
             *******/
             Ref 1
            /*******
             * TODO: Sub Task 1 The comparison function should always pass
             *******/
             Comp Always
            /*******
             * TODO: Sub Task 1 If the fragment passes, it should replace what
             * is in the stencil buffer
             *******/
             Pass Replace
        }

        CGPROGRAM

        // Define a surface shader in the surf function with
        // Lamert lighting and alpha (so nothing is drawn)
        #pragma surface surf Lambert alpha

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            float2 uv;
        };

        // The definition of our Surface Output structure for reference
        /*
        struct SurfaceOutput
        {
            fixed3 Albedo;  // diffuse color
            fixed3 Normal;  // tangent space normal, if written
            fixed3 Emission;
            half Specular;  // specular power in 0..1 range
            fixed Gloss;    // specular intensity
            fixed Alpha;    // alpha for transparencies
        };
        */

        // The surface function, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutput called o
        void surf (Input IN, inout SurfaceOutput o)
        {
            // This shader is only meant to write to the stencil buffer
            // so don't bother doing anything with the surface
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}

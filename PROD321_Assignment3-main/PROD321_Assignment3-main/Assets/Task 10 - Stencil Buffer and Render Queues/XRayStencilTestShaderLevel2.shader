/* In Task 10, you will be adding code this surface shader
 * to modify the stencil buffer allow objects to be
 * "xrayed" by objects using the xraytexture
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task10/XRayStencilTestShaderLevel2"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,1)
    }

    SubShader
    {
         /*******
         * TODO: Sub Task 2 Set the Render Queue to something greater
         * than our XRay Stencil Shader Objects, using the
         * Tags { "Queue" = "..." } function
         *******/


        Stencil
        {
            /*******
             * TODO: Sub Task 1 Set the ref value to 2
             *******/
            /*******
             * TODO: Sub Task 1 The comparison function should only pass if
             * the value of Ref is greater than what is currently
             * in the stencil buffer
             *******/

        }

        CGPROGRAM

        // Define a surface shader in the surf function with
        // Lamert lighting
        #pragma surface surf Lambert

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            float2 uv;
        };

        // The uniform variable for our diffuse colour property
        fixed4 _Color;

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
            // Set the surface output Albedo (Diffuse) colour to the _Color
            // variable
            o.Albedo = _Color;
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}

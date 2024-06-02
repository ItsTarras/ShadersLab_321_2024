/* In Task 8, you will be adding code this lambert surface
 * shader to support alpha transparency and an additional
 * depth pass to stop self occlusion overlapping
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task8/DepthPassAlphaColourSurfaceShader"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,.5)

        _AlphaVal ("Alpha Value", Range(0, 1)) = 0.5
    }

    // Our Shader Program
    SubShader
    {

        // The depth writing pass
        Pass {
            /*******
             * TODO: Turn on ZWriting
             *******/
             ZWrite On
            /*******
             * TODO: Disable writing to the frame buffer
             * using ColorMask 0
             *******/
             ColorMask 0
            
        }

        

        CGPROGRAM
        // Define a surface shader in the surf function
        /*******
         * TODO: Add alpha transparency support
         *******/
        #pragma surface surf Lambert alpha

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            float2 uv;
        };

        // The uniform variable for our diffuse colour property
        fixed4 _Color;
        float _AlphaVal;


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

            /*******
             * TODO: Set the Alpha value for the surface
             *******/
             o.Alpha = _AlphaVal;
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}

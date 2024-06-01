/* In Task 4, you will be adding code this surface
 * shader to support The Standard Metallic lighting model
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task4/StandardMetallicSurfaceShader"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,1)

        /*******
         * TODO: Add Metallic and Smoothness properties here
         *******/
         _Smoothness ("Smoothness", Range(0, 1)) = 0.5
         _Metallic ("Metallic", Range(0, 1)) = 0.5
    }

    // Our Shader Program
    SubShader
    {
        CGPROGRAM
        // Define a surface shader in the surf function
        /*******
         * TODO: Change Lighting Model
         *******/
        #pragma surface surf Standard

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            float2 uv;
        };

        // The uniform variable for our diffuse colour property
        fixed4 _Color;
        float _Metallic;
        float _Smoothness;

        /*******
         * TODO: Add uniform variables for Metallic and Smoothness
         * properties here
         *******/

        // The definition of our Surface Output Standard structure for reference
        
        /*
        struct SurfaceOutputStandard
        {
            fixed3 Albedo;      // base (diffuse or specular) color
            fixed3 Normal;      // tangent space normal, if written
            half3 Emission;
            half Metallic;      // 0=non-metal, 1=metal
            half Smoothness;    // 0=rough, 1=smooth
            half Occlusion;     // occlusion (default 1)
            fixed Alpha;        // alpha for transparencies
        };*/



        // The surface function, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutputStandard called o

        /*******
         * TODO: Change SurfaceOutput to SurfaceOutputStandard
         *******/
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Set the surface output Albedo (Diffuse) colour to the _Color
            // variable
            o.Albedo = _Color;
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;
            /*******
             * TODO: Set surface output standard Metallic and Smoothness here
             *******/
        }

        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}

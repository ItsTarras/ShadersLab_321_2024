/* In Task 4, you will be adding code this surface
 * shader to support The Standard Specular lighting model
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task4/StandardSpecularSurfaceShader"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,1)
        _Smoothness ("Smoothness", Range(0, 1)) = 0.5
        _SpecularColour ("Specular Colour", Color) = (1, 1, 1, 1)
        /*******
         * TODO: Add Specular Colour and Smoothness properties here
         *******/
    }

     // Our Shader Program
    SubShader
    {
        CGPROGRAM
        // Define a surface shader in the surf function
        /*******
         * TODO: Change Lighting Model
         *******/
        #pragma surface surf StandardSpecular

        // The input structure to our surface function, can't be
        // empty so we'll just define a UV set
        struct Input
        {
            float2 uv;
        };

        // The uniform variable for our diffuse colour property
        fixed4 _Color;

        /*******
         * TODO: Add uniform variables for Specular Colour and
         * Smoothness properties here
         *******/
         fixed4 _SpecularColour;
         float _Smoothness;

        // The definition of our Surface Output Standard Specular
        // structure for reference
        /*
        struct SurfaceOutputStandardSpecular
        {
            fixed3 Albedo;      // diffuse color
            fixed3 Specular;    // specular color
            fixed3 Normal;      // tangent space normal, if written
            half3 Emission;
            half Smoothness;    // 0=rough, 1=smooth
            half Occlusion;     // occlusion (default 1)
            fixed Alpha;        // alpha for transparencies
        };
        */


        // The surface function, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutputStandardSpecular called o

        /*******
         * TODO: Change SurfaceOutput to SurfaceOutputStandardSpecular
         *******/
        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            // Set the surface output Albedo (Diffuse) colour to the _Color
            // variable
            o.Albedo = _Color;
            /*******
             * TODO: Set surface output standard specular Specular Colour
             * and Smoothness here
             *******/
             o.Specular = _SpecularColour.rgb;
             o.Smoothness = _Smoothness;
        }
        ENDCG
    }

     // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}

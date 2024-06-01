/* In Task 6, you will be adding code this metallic surface
 * shader to mimic the image based lighting of the
 * metallic standard shader - specifically in regards to the
 * Smoothness and Metallic nature of the surface
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task6/Custom Metallic Surface Shader"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,1)

        // The main texture of the surface
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        // The smoothness of the surface
        _Smoothness ("Smoothness", Range(0,1)) = 0.5

        // The metallic value of our surface as a float
        /*******
         * TODO: Change this from a float to a texture
         *******/
        _MetallicMap ("Metallic Map", 2D) = "white" {}
    }

    
    // Our Shader Program
    SubShader
    {
        CGPROGRAM
        // Define a surface shader in the surf function using
        // the standard lighting model
        #pragma surface surf Standard

        // The input structure to our surface function
        struct Input
        {
            // The UV Coordinates for our main texture
            float2 uv_MainTex;

            /*******
             * TODO: Add the uv coordinates for our metallic texture
             *******/
             float2 uv_MetallicMap;
        };

        // The diffuse colour of our surface
        fixed4 _Color;

        // The sampler2D for our main texture
        sampler2D _MainTex;

        // The Smoothness value of our surface
        half _Smoothness;

        // The Metallic value of our surface
        /*******
         * TODO: Change this from a float to a texture
         *******/
        sampler2D _MetallicMap;

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
        };
        */

        // The surface function, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutputStandard called o
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Calculate the albedo (diffuse) colour by getting the
            // colour from the main texture, and multipying it by
            // the diffuse surface colour
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;

            // Set the Metallic and Smoothness values
            /*******
             * TODO: In the Standard shader, the metallic value
             * is taken from the RED channel of our Metallic texture for this
             * fragment, and the Smoothness is calculated as the ALPHA channel
             * of our Metallic texture at this fragment, multiplied by the
             * Smoothness float
             *******/
             // Lookup metallic and smoothness values from the texture
            float metallicValue = tex2D(_MetallicMap, IN.uv_MetallicMap).r; // Red channel.
            float smoothnessValue = tex2D(_MetallicMap, IN.uv_MetallicMap).a * _Smoothness; // Alpha channel

            o.Metallic = metallicValue;
            o.Smoothness = smoothnessValue;
        }

        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}

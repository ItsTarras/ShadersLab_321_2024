/* In Task 6, you will be adding code this sepcular surface
 * shader to mimic the image based lighting of the
 * specular standard shader - specifically in regards to the
 * Smoothness and Specular Colour of the surface
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task6/Custom Specular Surface Shader"
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

        // The specular reflection of our surface as a colour
        /*******
         * TODO: Change this from a colour to a texture
         *******/
        _SpecularMap ("Specular Map", 2D) = "white" {}
    }

    // Our Shader Program
    SubShader
    {
        CGPROGRAM
        // Define a surface shader in the surf function using
        // the standard specular lighting model
        #pragma surface surf StandardSpecular

        // The input structure to our surface function
        struct Input
        {
            // The UV Coordinates for our main texture
            float2 uv_MainTex;

            /*******
             * TODO: Add the uv coordinates for our specular texture
             *******/
             float2 uv_SpecularMap;
        };

        // The diffuse colour of our surface
        fixed4 _Color;

        // The sampler2D for our main texture
        sampler2D _MainTex;

        // The Smoothness value of our surface
        half _Smoothness;

        // The Specular colour of our surface
        /*******
         * TODO: Change this from a fixed4 to a texture
         *******/
        sampler2D _SpecularMap;

        // The definition of our Surface Output Standard Specular structure for reference
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
        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            // Calculate the albedo (diffuse) colour by getting the
            // colour from the main texture, and multipying it by
            // the diffuse surface colour
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;

            // Set the Specular Colour and Smoothness values
            /*******
             * TODO: In the Standard Specular shader, the Specular Colour
             * is taken from the RGB channels of our Specular texture for this
             * fragment, and the Smoothness is calculated as the ALPHA channel
             * of our Specular texture at this fragment, multiplied by the
             * Smoothness float
             *******/
            fixed3 specularColour = tex2D(_SpecularMap, IN.uv_SpecularMap).rgb;
            float smoothnessValue = tex2D(_SpecularMap, IN.uv_SpecularMap).a * _Smoothness;


            o.Specular = specularColour;
            o.Smoothness = smoothnessValue;
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}
